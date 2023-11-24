enum LoginResult {
  ok,
  accountExistsWithDifferentProvider,
  weakPassword,
  emailInUse,
  userNotFound,
  wrongPassword,
  invalidEmail,
  networkRequestFailed,
  generic,
}