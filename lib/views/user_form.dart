import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String,String> _formData = {};

  void _loadFormData(User user){
    if(user != null){ 

    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;

    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context).settings.arguments;
   
   _loadFormData(user);

    return Scaffold(
      appBar: AppBar(title: Text('Formulário de Usuario'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () {
            final isValid = _form.currentState.validate();
            if (isValid) {
              _form.currentState.save();
              Provider.of<Users>(context, listen: false).put(User(
                id: _formData['id'],
                name: _formData['name'],
                email: _formData['email'],
                avatarUrl: _formData['avatarUrl'],
               ));
              Navigator.of(context).pop();
            }
          },
        )
      ]),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _form,
          child: Column(children: <Widget>[
            Container(
                height: 45,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: new TextFormField(
                  initialValue: _formData['name'],
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      labelText: 'Nome',
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(100.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(color: Colors.grey[500]),
                      hintText: "Digite seu nome",
                      fillColor: Colors.white70),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                    return 'O nome deve estar preenchido';

                   } if (value.trim().length < 3) {
                      return 'Nome muito curto. No mínimo 3';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value,
                )),
            new TextFormField(
              initialValue: _formData['email'],
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Email',
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(100.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[500]),
                  hintText: "Digite seu Email",
                  fillColor: Colors.white70),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'O Email não pode estar vazio';
              },
               onSaved: (value) => _formData['email'] = value,
            ),
            new TextFormField(
              initialValue: _formData['avatarUrl'],
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  labelText: 'Url',
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(100.0),
                    ),
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[500]),
                  hintText: "Digite seu nome",
                  fillColor: Colors.white70),
              validator: (value) {
                if (value == null || value.isEmpty)
                  return 'A URL do avatar não pode estar vazio';
              },
               onSaved: (value) => _formData['avatarUrl'] = value,
            ),
          ]),
        ),
      ),
    );
  }
}
