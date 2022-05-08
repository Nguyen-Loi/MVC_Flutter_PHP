Ebook app
https://docs.flutter.dev/development/data-and-backend/json

Run 
flutter pub run build_runner build --delete-conflicting-outputs 

Why using shared_preferences in detail book?
1. When using add ebook -> add or delete that ebook -> save idFavorite (shared_preferences) that ebook
2. .get('saveFavorite') -> help me know update status that detail ebook  (aleready or notfound) in file php
3. If user want to use in otther case. You can using such as in (init state)
4. Different  (shared) when add or delete can know status idFavorite  (aleready or notfound) 
immediately -> load faster without check status on host