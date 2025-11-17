import 'package:demomanager/core/enums/app/app_user_type.dart';

import '../helper/locations.dart';

enum UserStatus { pending, approved, rejected }

class UserEntity {
  final String id;
  final String email;
  final String fullName;
  final String? diplomaUrl;
  final TRRegion trRegion;
  final AppUserType role;
  final bool isVerified;
  final UserStatus status;

  UserEntity({required this.id, required this.trRegion, required this.email, required this.fullName, required this.role, required this.isVerified, required this.status, required this.diplomaUrl});

  static UserStatus _statusFromString(String value) {
    switch (value) {
      case "approved":
        return UserStatus.approved;
      case "rejected":
        return UserStatus.rejected;
      default:
        return UserStatus.pending;
    }
  }

  static String _statusToString(UserStatus status) {
    switch (status) {
      case UserStatus.approved:
        return "approved";
      case UserStatus.rejected:
        return "rejected";
      default:
        return "pending";
    }
  }

  static AppUserType _roleFromString(String value) {
    switch (value) {
      case "doctor":
        return AppUserType.doctor;
      case "sales":
        return AppUserType.sales;
      default:
        return AppUserType.doctor;
    }
  }

  static TRRegion _regionFromString(String value) {
    switch (value) {
      case "Akdeniz":
        return TRRegion.Akdeniz;
      case "Ege":
        return TRRegion.Ege;
      case "Marmara":
        return TRRegion.Marmara;
      case "IcAnadolu":
        return TRRegion.IcAnadolu;
      case "Karadeniz":
        return TRRegion.Karadeniz;
      case "DoguAnadolu":
        return TRRegion.DoguAnadolu;
      case "GuneydoguAnadolu":
        return TRRegion.GuneydoguAnadolu;
      default:
        return TRRegion.Bilinmiyor;
    }
  }
  static String regionToString(TRRegion region) {
    switch (region) {
      case TRRegion.Akdeniz:
        return "Akdeniz";
      case TRRegion.Ege:
        return "Ege";
      case TRRegion.Marmara:
        return "Marmara";
      case TRRegion.IcAnadolu:
        return "IcAnadolu";
      case TRRegion.Karadeniz:
        return "Karadeniz";
      case TRRegion.DoguAnadolu:
        return "DoguAnadolu";
      case TRRegion.GuneydoguAnadolu:
        return "GuneydoguAnadolu";
      default:
        return "Bilinmiyor";
    }
  }

  static String _roleToString(AppUserType status) {
    switch (status) {
      case AppUserType.doctor:
        return "doctor";
      case AppUserType.sales:
        return "sales";
    }
  }

  factory UserEntity.fromJson(Map<String, dynamic> json, String documentId) {
    return UserEntity(
      trRegion: _regionFromString(json["region"]),
      id: documentId,
      email: json["email"] ?? "",
      fullName: json["fullName"] ?? "",
      diplomaUrl: json["diplomaUrl"],
      role: _roleFromString(json["role"] ?? "doctor"),
      isVerified: json["isVerified"] ?? false,
      status: _statusFromString(json["verificationStatus"] ?? "pending"),
    );
  }

  Map<String, dynamic> toJson() {
    return {"email": email, "fullName": fullName, "role": _roleToString(role), "isVerified": isVerified, "verificationStatus": _statusToString(status),"region":regionToString(trRegion)};
  }
}
