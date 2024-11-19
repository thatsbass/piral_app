users (collection)
│
├── {userId} (document, exemple: kjhashghaghjgghgas)
    │
    ├── nom: "bass"
    ├── prenom: "Jean"
    ├── adresse: "Dakar"
    ├── CIN: "8782787187"
    ├── telephone: "7787787787"
    ├── email: "jeanbass@gmail.com"
    ├── password: "123456"
    ├── role: "client"
    │
    ├── account (object)
    │   ├── balance: 3000
    │   ├── balanceMax: 1000000
    │   ├── balanceMensuel: 20000
    │   ├── status: "ACTIVE"
    │   ├── qrcode: "qrcodetoBase64"
    │
    ├── transfers (sous-collection)
    │   ├── {transferId} (document)
    │   │   ├── amount: 100
    │   │   ├── date: "2024-11-01T10:00:00Z"
    │   │   ├── type: "RECEIVE"
    │   │   ├── status: "SUCCESS"
    │   │   ├── fee: 10
    │   │   ├── sender (object)
    │   │       ├── firstName: "Jean"
    │   │       ├── lastName: "Mendi"
    │   │       ├── phone: "771302005"
    │   │
    │   ├── {transferId2} (document)
    │       ├── (idem structure précédente)
    │
    ├── transactions (sous-collection)
        ├── {transactionId} (document)
        │   ├── amount: 300
        │   ├── date: "2024-11-03T09:45:00Z"
        │   ├── type: "WITHDRAW"
        │   ├── status: "SUCCESS"
        │   ├── distributor: "MoneyGram"
        │
        ├── {transactionId2} (document)
            ├── (idem structure précédente)
