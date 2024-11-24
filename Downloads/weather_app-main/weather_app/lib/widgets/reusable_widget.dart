import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
    colorBlendMode: BlendMode.modulate,
  );
}

TextFormField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller, String? Function(String?)? validator) {
  return TextFormField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Color.fromARGB(255, 145, 140, 140),
    style:
        TextStyle(color: Color.fromARGB(255, 145, 140, 140).withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Color.fromARGB(255, 145, 140, 140),
      ),
      labelText: text,
      labelStyle:
          TextStyle(color: Color.fromARGB(255, 145, 140, 140).withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Color.fromARGB(255, 236, 236, 239).withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
    validator: validator, // Thêm validator ở đây
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)))),
    ),
  );
}
