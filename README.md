# accounts-movement-list

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