import Foundation

/// UI language. `.system` follows the user's preferred languages (Chinese → Simplified Chinese, Japanese → Japanese,
/// otherwise English).
public enum AppLanguage: String, Codable, Sendable, CaseIterable {
    case system
    case zhHans = "zh-Hans"
    case ja
    case en
}

public enum ResolvedLanguage: Sendable {
    case zhHans
    case ja
    case en
}

/// Runtime string selection. Strings are kept in code as (Chinese, English) pairs so both languages sit side by side
/// and switching needs no restart. Persisted identifiers (agent sources, quota window rows) are stored as keys and
/// turned into text through `sourceLabel` / `modelLabel`.
public enum L10n {
    private final class State: @unchecked Sendable {
        let lock = NSLock()
        var language: AppLanguage = .system
    }

    private static let state = State()

    public static func setLanguage(_ language: AppLanguage) {
        state.lock.withLock { state.language = language }
    }

    public static var language: AppLanguage {
        state.lock.withLock { state.language }
    }

    public static var resolved: ResolvedLanguage {
        switch language {
        case .zhHans: return .zhHans
        case .ja: return .ja
        case .en: return .en
        case .system: return systemLanguage()
        }
    }

    public static func systemLanguage(preferred: [String] = Locale.preferredLanguages) -> ResolvedLanguage {
        guard let first = preferred.first?.lowercased() else { return .en }
        if first.hasPrefix("zh") { return .zhHans }
        if first.hasPrefix("ja") { return .ja }
        return .en
    }

    /// Picks the string for the current language. Japanese comes from `Localization+Japanese.swift`, keyed by the
    /// Chinese and English pair so one English word can read differently by context ("Display" the screen and
    /// "Display" the verb); a pair without a translation yet shows the English. Call sites whose text interpolates a
    /// value pass the Japanese template themselves, since an interpolated runtime string cannot be looked up.
    public static func text(_ zh: String, _ en: String, _ ja: String? = nil) -> String {
        switch resolved {
        case .zhHans: return zh
        case .ja: return ja ?? japanese(zh: zh, en: en) ?? en
        case .en: return en
        }
    }

    /// The locale dates are written in: Chinese, Japanese, or British English, whose day before month and 24-hour clock
    /// match the rest of the interface.
    public static var dateLocale: Locale {
        switch resolved {
        case .zhHans: Locale(identifier: "zh_CN")
        case .ja: Locale(identifier: "ja_JP")
        case .en: Locale(identifier: "en_GB")
        }
    }

    /// Money and plain numbers: Chinese, Japanese, or US English, whose grouping the design uses.
    public static var numberLocale: Locale {
        switch resolved {
        case .zhHans: Locale(identifier: "zh_CN")
        case .ja: Locale(identifier: "ja_JP")
        case .en: Locale(identifier: "en_US")
        }
    }

    // MARK: Persisted keys → display text

    public static let sourceClaudeCode = "claude-code"
    public static let sourceClaudeSessions = "claude-sessions"
    public static let sourceBrowserAuth = "browser-auth"
    public static let sourceCodexAppServer = "codex-app-server"
    public static let sourceAdditionalUsage = "existing-login-usage"
    public static let sourceDeepSeekSessions = "deepseek-sessions"
    public static let sourceNotConnected = "not-connected"

    public static func sourceLabel(_ key: String) -> String {
        switch key {
        case sourceClaudeCode: return "Claude Code"
        case sourceClaudeSessions: return text("Claude Code 会话", "Claude Code sessions", "Claude Code セッション")
        case sourceBrowserAuth: return text("需浏览器授权", "Needs browser auth", "ブラウザ認証が必要")
        case sourceCodexAppServer: return text("本地客户端", "Local client", "ローカルクライアント")
        case sourceAdditionalUsage: return text("本地客户端", "Local client", "ローカルクライアント")
        case sourceDeepSeekSessions: return text("API 余额、费用与本地会话", "API balance, costs and local sessions",
                                                 "API 残高・費用・ローカルセッション")
        case sourceNotConnected: return text("未连接", "Not connected", "未接続")
        default: return key
        }
    }

    public static let windowSession = "window.session"
    public static let windowWeekly = "window.weekly"
    public static let windowWeeklyPrefix = "window.weekly."

    /// Quota window names stay in English for the Mac and every device that reads its data. Model names pass through.
    public static func modelLabel(_ model: String) -> String {
        if model == "Desktop / CLI" || model == "CLI" { return "Account quota" }
        if model == windowSession { return "Current session" }
        if model == windowWeekly { return "Weekly limit · All models" }
        if model.hasPrefix(windowWeeklyPrefix) {
            let family = model.dropFirst(windowWeeklyPrefix.count)
            return "Weekly limit · \(family)"
        }
        return model
    }

    /// Short form for tight places (`WindowNames`): "5h", "Weekly", a family's weekly window by the family alone
    /// ("Fable"), and a model by its first word ("Opus 4.5" → "Opus").
    public static func shortModelLabel(_ model: String) -> String {
        if model == "Desktop / CLI" || model == "CLI" { return "Quota" }
        if model == windowSession { return WindowNames.Period.fiveHours.shortName }
        if model == windowWeekly { return WindowNames.Period.week.shortName }
        if model.hasPrefix(windowWeeklyPrefix) { return WindowNames.leading(String(model.dropFirst(windowWeeklyPrefix.count))) }
        return model.split(separator: " ").first.map(String.init) ?? model
    }

    /// Sunday first, matching `Calendar.component(.weekday)`.
    public static var weekdayNames: [String] {
        switch resolved {
        case .zhHans: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        case .ja: ["日", "月", "火", "水", "木", "金", "土"]
        case .en: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        }
    }

    /// Monday first, for the heatmap rows.
    public static var weekdayNamesMondayFirst: [String] {
        let names = weekdayNames
        return Array(names[1...]) + [names[0]]
    }
}
