// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/modules/web_view/web_view_screen.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:toast/toast.dart';

//Button
Widget defaultButton({
  Color background = Colors.blue,
  double width = double.infinity,
  bool isUpperCase = true,
  @required String? text,
  @required Function? function,
}) =>
    Center(
      child: Container(
        width: width,
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: background,
        ),
        child: MaterialButton(
          // height: 40.0,
          onPressed: () {
            function!();
          },
          child: Text(
            isUpperCase ? text!.toUpperCase() : text!,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

Widget defaultTextButton({
  @required Function()? function,
  @required String? text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text!.toUpperCase()),
    );

// Text Form Feiled
Widget defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? type,
  String? Function(String?)? onSubmitted,
  //@required String? validate,
  @required String? labelText,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  Function? suffixPress,
  bool onPassword = false,
  Function(String)? onChange,
  @required String? Function(String?)? validate,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: onPassword,
      onChanged: onChange,
      validator: validate,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
          ),
          onPressed: () {
            suffixPress!();
          },
        ),
        border: const OutlineInputBorder(),
      ),
    );


Widget defaultFormField_Date({
  @required TextEditingController? controller,
  @required TextInputType? type,
  Function? onSubmitted,
  Function? onTap,
  @required String? validate,
  @required String? labelText,
  @required IconData? prefixIcon,
  IconData? suffixIcon,
  Function? suffixPress,
  bool onPassword = false,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: onPassword,
      onTap: () {
        onTap!();
      },
      onChanged: (val) {
        if (kDebugMode) {
          print(val);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return validate;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
          ),
          onPressed: () {
            suffixPress!();
          },
        ),
        border: const OutlineInputBorder(),
      ),
    );



Widget buildArticalItem(article, context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(article['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${article['urlToImage']}',
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget ArticalBuilder(
  list,
  context,
) =>
    ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticalItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      ),
      fallback: (context) => const Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      //عايز الغي يلي فات او اخلي true
      (Route<dynamic> route) => false,
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Toast.show(
      text,
      duration: Toast.lengthLong,
      gravity: Toast.bottom,
      backgroundColor: chooseToastColor(state),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
