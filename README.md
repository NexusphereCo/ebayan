# eBayan: Bridging Communities; Boosting Progress

An intuitive barangay-to-community mobile application for announcement creation management system.

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

## **Development** 👨‍💻

### Prerequisites

- NodeJS
- Dart
- Flutter
- FirebaseCLI

## **How to clone and run this project** 👨‍👨‍👦‍👦

1. Clone the project.

```bash
git clone https://github.com/NexusphereCo/ebayan.git
cd ebayan
flutter run
```

2. Import dependencies

```bash
dart pub get
```

3. Setup/Initialize project to firebase.

```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
flutterfire configure --project=ebayan-nexusphere
```

### **Seeding** 🌱

This is what the json data should look like

```json
{
  "__collections__": {
    "subjects": { // root collection
      "ITMC212": { // document
        "className": "Intermediate Programming",
        "__collections__": { // document sub-collection
          "materials": {
            "re152lyjhdA": {
              "type": "video",
              ...
            }
          }
        }
      },
      "ISMC211": { // document
        "className": "Introduction to Technopreneurship",
        "__collections__": { // document sub-collection
          "materials": {
            ...
          }
        }
      }
    }
  }
}
```

After running creating the data, run this command.

```bash
firestore-import --accountCredentials serviceKey.json --backupFile data.json
```

```bash
firestore-export --accountCredentials serviceKey.json --backupFile data.json --nodePath collectionA/docId/...
```

## **Miscellaneous** 🤷‍♂️

**Dart fix**

Run this command if there's any fixes that needs to be done if VSCode prompts the message

```bash
dart fix --apply
```

**How to clean flutter**

Run this command if there are build errors found in development. This refreshes the entire dependencies.

```
flutter clean
flutter pub get
```

## License 📋

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributors 👊

We greatly appreciate contributions to this project. Special thanks to the following contributors for their valuable input and efforts:

- [Gene Bitara](https://github.com/genebit)
- [Miguel Garcera](https://github.com/MD-Garcera)
