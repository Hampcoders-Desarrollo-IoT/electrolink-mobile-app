import 'package:flutter/material.dart';

enum UserRole {
  client,
  company,
  technician;

  String get label {
    switch (this) {
      case UserRole.client:
        return 'Dueño de Hogar';
      case UserRole.company:
        return 'Empresa';
      case UserRole.technician:
        return 'Técnico';
    }
  }

  String get iconLabel {
    switch (this) {
      case UserRole.client:
        return 'CH';
      case UserRole.company:
        return 'E';
      case UserRole.technician:
        return 'T';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.client:
        return Icons.home;
      case UserRole.company:
        return Icons.business;
      case UserRole.technician:
        return Icons.build;
    }
  }
}
