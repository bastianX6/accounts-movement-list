# accounts-movement-list

[![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=bastianX6_accounts-movement-list)](https://sonarcloud.io/dashboard?id=bastianX6_accounts-movement-list)
[![Build Status](https://app.bitrise.io/app/9dfe7385403be86f/status.svg?token=tNNiW2BcZea9enJqgWXRsA)](https://app.bitrise.io/app/9dfe7385403be86f)

This package contains the logic to:
- Show a summary of added movements.
- Show movements grouped by category/store.
- Allow edition/deletion of a movement.

Is used by [accounts](https://github.com/bastianX6/accounts) app.

# Targets

- `MovementListCommon`: Contains the base code used by "OS specific" targets (like `MovementList_iOS` and `MovementDetails_iOS`).
- `MovementList_iOS`: Contains the views and data structures show a summary of movements added in iOS devices.
- `MovementDetails_iOS`: Contains the views and data structures show movements grouped by category/store in iOS devices. Also allows to edit/delete a selected movement.


# Dependencies
- [DataManagement](https://github.com/bastianX6/accounts-data-management)
- [AccountsUI](https://github.com/bastianX6/accounts-ui)
- [NewMovement](https://github.com/bastianX6/accounts-new-movement)
- [DependencyResolver](https://github.com/bastianX6/accounts-dependency-resolver)