/// Represents the state of an asynchronous SharedPreferences operation
/// or any settings-related async workflow.
///
/// This enum is typically used by Cubits/Blocs to indicate the current
/// status during initialization or updates of persisted settings.
///
/// - [idle]     → No operation is in progress.
/// - [loading]  → An async task is currently running.
/// - [success]  → The operation completed successfully.
/// - [failure]  → The operation failed (e.g., read/write error).
enum SharedPrefsStatus {
  idle,
  loading,
  success,
  failure,
}
