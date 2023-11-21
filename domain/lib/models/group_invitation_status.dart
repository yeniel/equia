enum GroupInvitationStatus {
  pending,
  accepted,
  declined,
}

extension GroupInvitationStatusExtension on GroupInvitationStatus {
  String get stringValue => toString().split('.').last;
}
