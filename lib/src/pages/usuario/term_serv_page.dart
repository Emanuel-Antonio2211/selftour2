import 'package:flutter/material.dart';

class TermServPage extends StatelessWidget {
  final String termServ = """Minim aute consequat consequat enim esse id velit tempor elit consectetur elit. Eiusmod amet pariatur culpa veniam eu deserunt ullamco excepteur id et amet. Aute veniam nisi non nulla consequat cillum voluptate aute exercitation ullamco. Deserunt aliqua irure incididunt minim reprehenderit do labore. Lorem ex veniam non ullamco dolor quis ad et dolore officia.

Elit reprehenderit enim elit ad labore eiusmod ad ullamco ea incididunt id occaecat. Veniam non aliquip dolore Lorem sit elit dolore. Duis reprehenderit consectetur mollit occaecat reprehenderit consequat fugiat pariatur est. Ullamco non proident ea minim ipsum. Quis id ad dolore Lorem dolore aliqua minim nostrud dolore. Aliqua sunt pariatur qui duis esse qui qui do culpa.

Officia est sint ullamco consequat do. Mollit consequat non exercitation tempor ex laborum ea qui dolore proident consectetur. Nulla ex magna consectetur aliqua incididunt amet dolor est sit aute enim.

Proident ut anim nostrud ea quis. Ad ut Lorem officia ut ad anim consequat fugiat incididunt non non ut. Lorem deserunt do sunt elit ea dolore ea amet voluptate dolore sint Lorem. Officia exercitation tempor commodo excepteur quis aliqua ea commodo Lorem.

Pariatur consequat laboris commodo minim. Fugiat eiusmod eu sint id incididunt irure voluptate nostrud amet pariatur eiusmod duis. Commodo voluptate proident enim exercitation non. Ad ex voluptate nostrud sint qui nostrud cupidatat eu cupidatat do tempor. Nisi nulla qui voluptate deserunt Lorem amet aliquip incididunt cillum ea incididunt cillum et. Officia sit duis reprehenderit dolor mollit est exercitation in. Commodo do mollit enim fugiat commodo mollit culpa quis dolor qui id veniam.

Ad laboris laborum pariatur officia nulla exercitation laboris exercitation consequat. Laboris id labore labore deserunt nulla consectetur ullamco dolore nisi anim enim. Ullamco deserunt pariatur ad et dolor. Ipsum reprehenderit ut duis elit nisi in nulla ullamco. In nisi veniam labore officia ipsum cillum deserunt eiusmod incididunt ea elit minim commodo est.

Incididunt Lorem id magna sint nisi cupidatat pariatur enim voluptate qui ex anim labore ut. Cupidatat veniam aute officia amet ad cupidatat. Adipisicing laboris excepteur non commodo eu ullamco quis non proident. Anim ut tempor ipsum labore voluptate ipsum nostrud ipsum duis magna Lorem. Consequat sint est proident laborum.

Consequat et aliquip reprehenderit non commodo deserunt in. Aliquip tempor dolore pariatur sint adipisicing tempor minim. Ad pariatur id elit nisi voluptate non laborum aute dolor ad id pariatur. Ut commodo incididunt quis aute culpa dolore adipisicing occaecat voluptate anim quis laborum non. Nostrud do est minim aliquip do occaecat cillum cillum voluptate ullamco. Nisi dolore Lorem culpa do est minim proident non do elit nisi ad laboris.""";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(termServ,textAlign: TextAlign.justify,style: TextStyle(fontFamily: 'Point-SemiBold'),)
          ],
        ),
      ),
    );
  }
}