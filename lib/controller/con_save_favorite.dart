import 'package:dio/dio.dart';
import 'package:ebook_app/controller/api.dart';
import 'package:ebook_app/view/component/alert_main.dart';
import 'package:ebook_app/widget/common_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

saveToFavorite(
    {required BuildContext context,
    required String idCourse,
    required String idUser}) async {
  var data = {'id_course': idCourse, 'id_user': idUser};
  var req = await Dio()
      .post(ApiConstant().baseUrl() + ApiConstant().saveFavorite, data: data);

  var checkFav = await Dio()
      .post(ApiConstant().baseUrl() + ApiConstant().checkFavorite, data: data);

  if (req.data == 'success') {
    await msgAlert(
        title: 'Added to Favorite',
        description: 'This Ebook was added to your favorite',
        alertType: AlertType.success,
        context: context,
        onPressed: () {
          Navigator.pop(context);
          saveFavoriteEbook(checkFav.data);
        });
  } else {
    await msgAlert(
        title: 'Delete from favorite',
        description: 'This Ebook was delete to your favorite',
        alertType: AlertType.warning,
        context: context,
        onPressed: () {
          Navigator.pop(context);
          saveFavoriteEbook(checkFav.data);
        });
  }
}
