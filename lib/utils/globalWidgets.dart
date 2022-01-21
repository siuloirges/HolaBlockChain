// ignore_for_file: prefer_const_constructors
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

//TextStyles
TextStyle primaryStyle = TextStyle(
    color: primaryColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: "titulo");

TextStyle primaryStyle2 =
    TextStyle(color: Colors.white, fontSize: 20, fontFamily: "titulo");
TextStyle primaryStyle3 = TextStyle(
    color: Color.fromRGBO(255, 255, 255, 1),
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: "titulo");
TextStyle secondaryStyle = TextStyle(
    color: Color.fromRGBO(40, 56, 53, 0.5), fontSize: 15, fontFamily: "titulo");
TextStyle secondaryStyle2 = TextStyle(
    color: Color.fromRGBO(40, 56, 53, 0.5), fontSize: 12, fontFamily: "titulo");

//Colors
Color primaryColor = Color.fromRGBO(93, 181, 165, 1);
Color primaryColorOpa = Color.fromRGBO(93, 181, 165, 0.3);
Color segundaryColor = Color.fromRGBO(40, 56, 53, 1);

//widgets
Widget horizontalScrollBox(Size size, {List<Widget> list, Function onTap}) {
  return Column(
    children: [
      Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10,
              )
            ]..addAll(list),
          ),
        ),
      ),
    ],
  );
}

Widget horizontalRoundButton(String text,
    {bool active = false, Function onTap, bool disable = false}) {
  return Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
            color: active
                ? Colors.amber.withOpacity(0.4)
                : disable
                    ? Colors.grey.withOpacity(0.3)
                    : Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(100))),
        height: 40,
        // width: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Center(
              child: Text("$text",
                  style:
                      TextStyle(color: active ? primaryColor : Colors.black))),
        ),
      ),
    ),
  );
}

primaryButton(BuildContext context, Size size,
    {Function onpress, String texto}) {
  return Container(
    height: 65,
    width: size.width * 0.9,
    padding: EdgeInsets.only(
      top: 5,
      left: 5,
      bottom: 5,
    ),
    margin: EdgeInsets.only(bottom: 20),
    child: RaisedButton(
      elevation: 2,
      color: primaryColor,
      shape: StadiumBorder(),
      onPressed: onpress,
      child: Center(
        child: Text('$texto', style: primaryStyle2),
      ),
    ),
  );
}

floadMessage(
    {String titulo,
    String mensaje,
    Duration duration,
    ToastPosition toastPosition,
    double bigHeight,
    int maxLine,
    double borderRadius}) {
  showToastWidget(
    FadeInUp(
      duration: Duration(milliseconds: 500),
      child: GestureDetector(
        child: Container(
          height: bigHeight ?? 50,
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(.4),
              borderRadius: BorderRadius.circular(borderRadius ?? 100)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Text(
                      "${mensaje ?? ''}",
                      maxLines: bigHeight == null ? 1 : maxLine ?? 1,

                      //  overflow: TextOverflow.clip,
                      style: TextStyle(color: Colors.yellow),

                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    position: toastPosition ?? ToastPosition.bottom,
    duration: duration ?? Duration(seconds: 3),
  );
}

alerta(BuildContext context,
    {bool code = true,
    String titulo,
    dynamic contenido,
    Widget acciones,
    bool dismissible,
    bool done,
    Widget onpress,
    Color colorTitulo,
    Color colorContenido,
    bool weight = false}) {
    return showDialog(
      barrierDismissible: dismissible ?? true,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Color.fromRGBO(246, 245, 250, 1),
          title: Container(
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  '${titulo ?? 'Alerta'}',
                  style: TextStyle(color: colorTitulo ?? Colors.grey),
                )),
              )),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Container(
                      width: double.infinity,
                      // height: size.width>450?200: size.height * 0.22,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            code == true
                                ? contenido
                                : Text('$contenido',
                                    style: TextStyle(
                                        color: colorContenido ?? Colors.grey,
                                        fontWeight: weight == false
                                            ? FontWeight.w400
                                            : FontWeight.bold))
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: done == true
                            ? Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          child: Icon(Icons.arrow_back,
                                              color: Colors.white),
                                          width: 50,
                                          height: 50,
                                          decoration: ShapeDecoration(
                                              color: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10))),
                                        )),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: onpress),
                                ],
                              )
                            : done == false
                                ? Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              child: Icon(Icons.arrow_back,
                                                  color: Colors.white),
                                              width: 50,
                                              height: 50,
                                              decoration: ShapeDecoration(
                                                  color: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10))),
                                            )),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [acciones ?? Container()],
                                  ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
