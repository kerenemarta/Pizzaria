import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:estudo/abertura.dart';
import 'package:video_player/video_player.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF5D2B21)
        ),
      ),
      home:  Abertura(),

    );
  }
}

class Telalogin extends StatefulWidget {
  @override
  State<Telalogin> createState() => _TelaApresentacaoEstado();
}

class _TelaApresentacaoEstado extends State<Telalogin> {
  final PageController _controlador = PageController();
  int paginaAtual = 0;

  final List<Map<String, String>> paginas = [
    {
      "imagem": "assets/tela1.png",
      "titulo": "Descubra novos sabores!",
      "subtitulo": "Conheça pizzas exclusivas criadas pelos nossos chefs e pelos próprios clientes."   },
    {
      "imagem": "assets/tela2.png",
      "titulo": "Sabor, rapidez e confiança",
      "subtitulo": "Com um toque, a pizza perfeita está a caminho da sua mesa!"  },
    {
      "imagem": "assets/tela3.png",
      "titulo": "Evite filas enormes na compra da sua Pizza !",
      "subtitulo": "Navegação rápida e pagamento simples. O sabor vem até você!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  NotificationListener<ScrollNotification>(
          onNotification: (notification){

            if (notification is OverscrollNotification &&
                paginaAtual== paginas.length-1) {

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => Dashboard()),
              );

            }

            return false;
          },
          child: PageView.builder(
            controller: _controlador,
            itemCount: paginas.length,
            onPageChanged: (indice) {
              setState(() => paginaAtual = indice);
            },
            itemBuilder: (context, indice) {
              final pagina = paginas[indice];
              return Stack(
                children: [
                  Image.asset(
                    pagina["imagem"]!,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pagina["titulo"]!,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.brown,
                                offset: Offset(5, 3),
                                blurRadius: 1,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          pagina["subtitulo"]!,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                offset: Offset(3, 1),
                                blurRadius: 1,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            paginas.length,
                                (indicePonto) => Container(
                              margin:
                              const EdgeInsets.symmetric(horizontal: 3),
                              width: paginaAtual == indicePonto ? 50 : 8,
                              height: 6,
                              decoration: BoxDecoration(
                                color: paginaAtual == indicePonto
                                    ? Colors.blue
                                    : Colors.orange,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  if (paginaAtual == indicePonto)
                                    const BoxShadow(
                                      color: Colors.cyanAccent,
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              );
            })));







  }
}

class Dashboard extends StatefulWidget{
  @override
  State<Dashboard> createState()=> _Apresenta();
}

class _Apresenta extends State<Dashboard>{
    final PageController _controlador = PageController();
    int paginaAtual = 0;

    final GoogleSignIn _googleSignIn= GoogleSignIn();

    Future<void> loginComGoogle()
        async{
    try {
      final GoogleSignInAccount? conta =
      await _googleSignIn.signIn();
      if (conta != null) {
        print('Seja Bem-Vindo(a): ${conta.email}');
      }
    }
    catch (error){
    print('Erro no login: $error');

    }

    }



    final List<Map<String, String>> paginas = [
      {
        "imagem": "assets/pizz4.jpeg",
        "titulo": " Entre com uma conta Google",
        "subtitulo": "Entre com uma conta da google para ter acesso aos nossos serviços."   },

    ];

    @override
    Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Color(0xFF6B402F),
        body: Stack(

          children: [
            PageView.builder(
              controller: _controlador,
              itemCount: paginas.length,
              onPageChanged: (indice) {
                setState(() => paginaAtual = indice);
              },
              
              itemBuilder: (context, indice) {
                final pagina = paginas[indice];
                return  Padding(
                  padding: const EdgeInsets.only(top: 50,left: 30,right: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ClipRRect(
                      borderRadius: BorderRadius.circular(48),
                      child:  Image.asset(
                      pagina["imagem"]!,
                      fit: BoxFit.cover,
                      height: 500,
                      width: 325,


                    ),

                    ),




Container(
    padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,

      children:[
        Text(
          pagina["titulo"]!,
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Billabong",
              shadows: [
                Shadow(
                    color: Colors.brown,

                    offset: Offset(1, 1),
                    blurRadius: 1)]
          ),
        ),

        const SizedBox(height: 7),

        Text(
          pagina["subtitulo"]!,
          style:
          const TextStyle(
              fontSize: 14,
              fontFamily: "Inter",
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    color: Colors.brown,

                    offset: Offset(1, 1),
                    blurRadius: 1)]
          ),
        ),

        const SizedBox(height: 48),




      ],


    ),

  ),


                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),

                              onPressed: () {  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  PaginamenuPizzaestado(),
                                ),
                              );},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Positioned(child:  Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black,


                                      ],
                                    ),
                                  ),
                                ),
                                ),

                                  Image.asset("assets/google.png", height: 24, width: 24),
                                  const SizedBox(width: 8),
                                  const Flexible(
                                    child: Text(
                                      "Entrar com o Google",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                  ],
                ));
              },
            ),


          ],
        ),
      );
    }


  }

  class PaginamenuPizzaestado extends StatefulWidget{
  @override
    _PaginamenuPizza createState()=> _PaginamenuPizza();
  }

class _PaginamenuPizza extends State <PaginamenuPizzaestado> {
  List<Map<String, dynamic>> selectedIndexes = [];


  int? currentIndex;

  Map<int, int> pizzaQuantidades = {};
//Esta é a área das listas, onde encontramos as imagens e videos de cada item.Responsavel pela abertura exata de cada elemento.

  final List<Map<String, dynamic>> pizzas = [
    {
      'name': 'Margherita',
      'image': 'assets/pizza4.png',
      'in':'Molho de tomate',
      'ingre':'Mussarela',
      'ingredi':'Manjericão fresco',
      'ingredients':'Azeite de oliva',
      'video':'assets/pizza.mp4',
      'descricao':'A Pizza torna tudo mais delicioso, com ingredientes únicos para deixa-lo com agua na boca, onde cada divisão, traz uma chuva de sabores',
      'price': 6700.0,
    },

    {
      'name': 'Mexicana',
      'image': 'assets/pizza6.png',
      'in':'Carne Moída',
      'ingre':'Pimenta',
      'ingredi':'Milho',
      'ingredientes':'Cheddar',
      'video':'assets/pizza.mp4',
      'descricao':'A Pizza torna tudo mais delicioso, com ingredientes únicos para deixa-lo com agua na boca, onde cada divisão, traz uma chuva de sabores',
      'price': 6500.0,
    },

  ];

  final List<Map<String, dynamic>> pizzaas = [
    {
      'name': 'Margherita Mini',
      'image': 'assets/pizza4.png',
      'in':'Molho de tomate',
      'ingre':'Mussarela',
      'ingredi':'Manjericão fresco',
      'ingredients':'Azeite de oliva',
      'video':'assets/pizza.mp4',
      'descricao':'A Pizza torna tudo mais delicioso, com ingredientes únicos para deixa-lo com agua na boca, onde cada divisão, traz uma chuva de sabores',
      'price': 3700.0, },
    {
      'name': 'Pizzaiolo Mini',
      'image': 'assets/pizza1.png',
      'in':'Presunto',
      'ingre':'Calabresa',
      'ingredi':'Cebola',
      'ingredients':'Azeitona',
      'video':'assets/pizza.mp4',
      'descricao':'A Pizza torna tudo mais delicioso, com ingredientes únicos para deixa-lo com agua na boca, onde cada divisão, traz uma chuva de sabores',
      'price': 3500.0,
    },
    {
      'name': 'Vegetariana Mini',
      'image': 'assets/pizza6.png',
      'in': 'Legumes',
      'ingre':'Brócolis',
      'ingredi':'Palmito',
      'ingredients':'Tomate seco',
      'video':'assets/pizza.mp4',
      'descricao':'A Pizza torna tudo mais delicioso, com ingredientes únicos para deixa-lo com agua na boca, onde cada divisão, traz uma chuva de sabores',
       'price': 3000.0
    },


  ];
  final List<Map<String, dynamic>> pizzaaas = [

    {
      'name': 'Vegetariana',
      'image': 'assets/pizza6.png',
      'in':'Legumes',
      'ingre':'Brócolis',
      'ingredi':'Palmito',
      'ingredients':'Tomate seco',
      'video':'assets/pizza.mp4',
      'descricao':'A Pizza torna tudo mais delicioso, com ingredientes únicos para deixa-lo com agua na boca, onde cada divisão, traz uma chuva de sabores',
      'price': 6000.0
    },

    {
      'name': 'Pizzaiolo Mini',
      'image': 'assets/pizza1.png',
      'in': 'Presunto',
      'ingre':'Calabresa',
      'ingredi':'Cebola',
      'ingredients':'Azeitona',
      'video':'assets/pizza.mp4',
      'descricao':'A Pizza torna tudo mais delicioso, com ingredientes únicos para deixa-lo com agua na boca, onde cada divisão, traz uma chuva de sabores',
      'price': 7000.0,
    },
  ];

  bool showOptions = false;
  bool showQuantityMenu = false;
  int quantity = 1;
  List<Map<String, dynamic>> pizzasSelecionadas = [];
  String? currentList;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E1F1B),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right:  8),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade700,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(13)
                    ),
                    child: const Text('   Histórico de Pedidos', style: TextStyle(color:Colors.white,height: 2.3),),
                    width: 160, ),

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade700,
                      shape: BoxShape.circle,
                    ),
                    child:
                    Icon(Icons.history, color: Colors.white,)
                  ),

                ],
              ),

              const SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade700,
                        shape: BoxShape.circle,
                      ),
                      child:
                      Icon(Icons.timer, color: Colors.white,)
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        color: Colors.brown.shade700,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(13)
                    ),
                    child: const Text('Pedidos em andamento', style: TextStyle(color:Colors.white,height: 2.3),),
                    width: 165, ),



                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'Que pizza preferes?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 35),

              Expanded(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 40,
                    runSpacing: 11,
                    children: List.generate(pizzas.length, (index) {
                      final pizza = pizzas[index];
                      final isSelected = selectedIndexes.contains(index);



                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentList = 'pizzas';
                              if (currentIndex == index && showOptions) {
                                showOptions = false;
                                showQuantityMenu = false;
                                currentIndex = null;
                              } else {
                                currentIndex = index;
                                showOptions = true;
                                showQuantityMenu = false;
                              }
                            });
                          },


                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                            transform: isSelected
                                ? (Matrix4.translationValues(0, -10, 0))
                                : Matrix4.identity(),
                            child: Transform.rotate(
    angle: -2.3,
    child: Container(
    width: 120,
    height: 120,
    decoration: BoxDecoration(
    color: Colors.brown.shade800,
    borderRadius: BorderRadius.circular(20),
    border:Border.all(color: Colors.brown),
    boxShadow: [
    BoxShadow(
    color: Colors.black.withOpacity(0.4),
    blurRadius: 2,
    offset: const Offset(1, 1),
    ),
    ],
    ),
    child: Transform.rotate(
    angle: - 4,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset(
    pizza['image'],
    height: 100,
    width: 100,
    ),

      Text(
        pizza['name'],
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      ),

    ],
    ),
    ),
    ),
    ),
    ));
    }).toList(),
    ),
    ),
    ),

             SizedBox(height: 135),
              Expanded(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    spacing: 26.3,
                    runSpacing: 1,
    children: List.generate(pizzaas.length, (index) {
    final pizza = pizzaas[index];
    final isSelected = selectedIndexes == index;


    return GestureDetector(
    onTap: () {
    setState(() {
    currentList = 'pizzaas';
    if (currentIndex == index && showOptions) {
    showOptions = false;
    showQuantityMenu = false;
    currentIndex = null;
    } else {
    currentIndex = index;
    showOptions = true;
    showQuantityMenu = false;
    }
    });
    },


    child: AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
    transform: isSelected
    ? (Matrix4.translationValues(0, -10, 0))
        : Matrix4.identity(),
    child: Transform.rotate(
    angle: -2.3,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.brown.shade800,
                              borderRadius: BorderRadius.circular(20),
                              border:Border.all(color: Colors.brown),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.9),
                                  blurRadius: 8,

                                  offset: const Offset(5, 5),
                                ),
                              ],
                            ),
                            child: Transform.rotate(
                              angle: - 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    pizza['image'],
                                    height: 80,
                                    width: 80,
                                  ),
                                   SizedBox(height: 1),
                                  Text(
                                    pizza['name'],
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),

                                ],
      ),
      ),
      ),
      ),
      ));
      }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 115),
              Expanded(
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 40,
                    runSpacing: 3,
                    children: List.generate(pizzaaas.length, (index) {
                      final pizza = pizzaaas[index];
                      final isSelected = selectedIndexes == index;


                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              currentList = 'pizzaaas';
                              if (currentIndex == index && showOptions) {
                                showOptions = false;
                                showQuantityMenu = false;
                                currentIndex = null;
                              } else {
                                currentIndex = index;
                                showOptions = true;
                                showQuantityMenu = false;
                              }
                            });
                          },

                          child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      transform: isSelected
                      ? (Matrix4.translationValues(0, -10, 0))
                          : Matrix4.identity(),
                      child: Transform.rotate(
                          angle:  -2.3,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.brown.shade800,
                              borderRadius: BorderRadius.circular(20),
                              border:Border.all(color: Colors.brown),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.9),
                                  blurRadius: 89,
                                  offset: const Offset(5, 3),

                                ),
                              ],
                            ),
                            child: Transform.rotate(
                              angle: - 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    pizza['image'],
                                    height: 100,
                                    width: 100,
                                  ),

                                  Text(
                                    pizza['name'],
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),


                                ],
                              ),
                            ),
                          ),
                      ),
                      ));
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 90),



            Row(
              children: [
                if (showOptions && currentIndex != null)

                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    right: showOptions ? 10 : -150,
                    top: 10,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: showOptions ? 1 : 0,
                      child: Container(
                        width: 180,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.brown.shade700,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.visibility, color: Colors.white),
                              title: const Text("Ver Detalhes", style: TextStyle(color: Colors.white)),
                              onTap: () {
                                final pizza = currentList == 'pizzas'
                                    ? pizzas[currentIndex!]
                                    : currentList == 'pizzaas'
                                    ? pizzaas[currentIndex!]
                                    : pizzaaas[currentIndex!];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => PizzaDetailPage(pizza: pizza),
                                  ),
                                );
                              },

                            ),
                            ListTile(
                              leading: const Icon(Icons.add_shopping_cart, color: Colors.white),
                              title: const Text("Selecionar", style: TextStyle(color: Colors.white)),
                              onTap: () {
                                setState(() {
                                  showQuantityMenu = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                if (showQuantityMenu && currentIndex != null)

                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    right: showQuantityMenu ? 220 : -150,
                    top: 10,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: showQuantityMenu ? 1 : 0,
                      child: Container(
                        width: 130,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.brown.shade700,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Quantidade",
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (quantity > 1) quantity--;
                                    });
                                  },
                                  icon: const Icon(Icons.remove_circle, color: Colors.orangeAccent),
                                ),
                                Text(
                                  "$quantity",
                                  style: const TextStyle(color: Colors.white, fontSize: 18),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() => quantity++);
                                  },
                                  icon: const Icon(Icons.add_circle, color: Colors.lightGreen),
                                ),
                              ],
                            ),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                final index = currentIndex!;
                                final pizza = currentList == 'pizzas'
                                    ? pizzas[index]
                                    : currentList == 'pizzaas'
                                    ? pizzaas[index]
                                    : pizzaaas[index];

                                setState(() {
                                  pizzaQuantidades[index] = quantity;
                                  selectedIndexes.add({
                                    'index': index,
                                    // salva de qual lista veio
                                    'list': currentList,
                                  });

                                  showOptions = false;
                                  showQuantityMenu = false;
                                  quantity = 1;
                                  currentIndex = null;
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${pizza['name']} adicionada (${pizzaQuantidades[index]})"),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },


                              child: const Text("Guardar", style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Modo de seleção ativado")),
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Selecionar Pizzas",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaginaPagamento(
                                pizzasSelecionadas: selectedIndexes.map((item) {
                                  final index = item['index'];
                                  final listName = item['list'];

                                  final pizza = listName == 'pizzas'
                                      ? pizzas[index]
                                      : listName == 'pizzaas'
                                      ? pizzaas[index]
                                      : pizzaaas[index];

                                  final qtd = pizzaQuantidades[index] ?? 1;
                                  final preco = pizza['price'];

                                  return {
                                    'nome': pizza['name'],
                                    'quantidade': qtd,
                                    'price': preco,
                                    'subtotal': preco * qtd,
                                  };
                                }).toList(),

                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Efetuar Pagamento",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    ]
    )
    )
    )
    );

  }
}


class PizzaDetailPage extends StatefulWidget {
  final Map<String, dynamic> pizza;

  const PizzaDetailPage({required this.pizza, Key? key}) : super(key: key);

  @override
  State<PizzaDetailPage> createState() => _PizzaDetailPageState();
}

class _PizzaDetailPageState extends State<PizzaDetailPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }
//Esta área é responsavel pelos itens que aparecem nos detalhes de cada pizza, como:video, titulo, descrição e preço.
  void _initializeVideo() {
    try {
      _controller = VideoPlayerController.asset(widget.pizza['video'])
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
            });
            _controller.play();
            _controller.setLooping(true);
            _controller.setVolume(0);
          }
        })
        //Caso aconteça algum erro com o Video ao ser rodado
            .catchError((error) {
          if (mounted) {
            setState(() {
              _hasError = true;
              _errorMessage = 'Erro ao carregar vídeo: $error';
            });
          }
          print('Erro ao inicializar vídeo: $error');
        });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Erro ao criar controller: $e';
      });
      print('Erro ao criar VideoPlayerController: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pizza = widget.pizza;

    return Scaffold(
      backgroundColor:  Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(pizza['name'],style: TextStyle(color: Colors.transparent),),


        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Container(
              height: 320,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: _hasError
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Erro ao carregar vídeo',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : _isInitialized
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
                  : const Center(
                child: CircularProgressIndicator(
                  color: Colors.orangeAccent,
                ),
              ),
            ),

            Text(
              pizza['name'],
              style: const TextStyle(
                fontSize: 30,
                fontFamily: 'Billabong',
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 20),

            if (pizza['in'] != null)
              Text(
                pizza['in'],
                textAlign: TextAlign.center,

                style: const TextStyle(  fontSize: 20,
                    fontFamily: 'Billabong',
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            if (pizza['ingre'] != null)
              Text(
                pizza['ingre'],
                textAlign: TextAlign.center,
                style: const TextStyle(  fontSize: 20,
                    fontFamily: 'Billabong',
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            if (pizza['ingredi'] != null)
              Text(
                pizza['ingredi'],
                textAlign: TextAlign.center,
                style: const TextStyle(  fontSize: 20,
                    fontFamily: 'Billabong',
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            if (pizza['ingredients'] != null)
              Text(
                pizza['ingredients'],
                textAlign: TextAlign.center,
                style: const TextStyle(  fontSize: 20,
                    fontFamily: 'Billabong',
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            const SizedBox(height: 20),

            Text(
              pizza['descricao'] ?? '',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Billabong',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            Text(
              "${pizza['price']} Kz",
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaPagamento extends StatelessWidget {
  final List<Map<String, dynamic>> pizzasSelecionadas;

  const PaginaPagamento({Key? key, required this.pizzasSelecionadas}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var pizza in pizzasSelecionadas) {
      //Calculo responsavel pelo valor Total das pizzas selecionadass
      total += pizza['price'] * pizza['quantidade'];
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo do Pedido'),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: const Color(0xFF2E1F1B),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pizzas Selecionadas:',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
              ListView.builder(
                itemCount: pizzasSelecionadas.length,
                itemBuilder: (context, index) {
                  final pizza = pizzasSelecionadas[index];
                  return ListTile(
                    title: Text(pizza['nome'],style: TextStyle(color: Colors.white70),),
                    subtitle: Text("Quantidade: ${pizza['quantidade']}",style: TextStyle(color: Colors.orange),),
                    trailing: Text("Kz ${(pizza['subtotal']).toStringAsFixed(2)}",style: TextStyle(color: Colors.lightGreen),),
                  );
                },
              )

            ),
            const SizedBox(height: 20),
            Text(
              "Total: ${total.toStringAsFixed(2)} kz",
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {Navigator.push(context,
                    MaterialPageRoute(
                        builder: (_)=>Entregaandamento(
                          pizzasSelecionadas: [],
                        )));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pagamento efetuado com sucesso!')),
                  );
                },
                child: const Text('Confirmar Pagamento', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

}

class Entregaandamento extends StatelessWidget {
  final List<Map<String, dynamic>> pizzasSelecionadas;

  const Entregaandamento({Key? key, required this.pizzasSelecionadas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pedido em andamento',
          style: TextStyle(
            color: Colors.lightGreen,
            fontWeight: FontWeight.bold,
            fontFamily: 'Billabong',
            fontSize: 30,
            letterSpacing: 2,
          ),
        ),
        backgroundColor: Color(0xFF2E1F1B),
      ),
      backgroundColor: Colors.brown,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/entrega.png'),
            Text(
              'Obrigado pela preferência! ',
              style: TextStyle(color: Colors.white70, fontSize: 20),
            ),
            Text(
              'Seu pedido está em andamento! ',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 80),
            Text(
              "Acompanhe o seu pedido",
              style: const TextStyle(
                color: Colors.orangeAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RastreamentoEntrega(
                        pizzasSelecionadas: pizzasSelecionadas,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Acompanhar Pedido',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//Apartir desta tela, o cliente seleciona a sua localização
class TelaSelecaoLocalizacao extends StatefulWidget {
  const TelaSelecaoLocalizacao({Key? key}) : super(key: key);

  @override
  State<TelaSelecaoLocalizacao> createState() => _TelaSelecaoLocalizacaoState();
}

class _TelaSelecaoLocalizacaoState extends State<TelaSelecaoLocalizacao> {
  GoogleMapController? _mapController;
  LatLng? _localizacaoSelecionada;
  // Localização de Luanda para que o mapa não abra em um sitio aleatório do mundo
  LatLng _localizacaoInicial = LatLng(-8.8383, 13.2344);
  Set<Marker> _markers = {};
  bool _localizacaoConfirmada = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E1F1B),
      body: Stack(
        children: [

          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _localizacaoInicial,
              zoom: 14,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: (position) {
              setState(() {
                _localizacaoSelecionada = position;
                _localizacaoConfirmada = false;
                _atualizarMarcador(position);
              });
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2E1F1B),
                    Color(0xFF2E1F1B).withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Marque sua localização',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Toque no mapa onde você está',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),


          Positioned(
            right: 20,
            top: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              children: [
                // Botão que leva a localização
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: _irParaMinhaLocalizacao,
                    icon: Icon(Icons.my_location, color: Colors.blue),
                    iconSize: 28,
                  ),
                ),
                SizedBox(height: 15),
                // Botão zoom in
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  //Botão responsavel pelo zoom de ampliação
                  child: IconButton(
                    onPressed: () => _zoom(true),
                    icon: Icon(Icons.add, color: Colors.black87),
                    iconSize: 28,
                  ),
                ),
                SizedBox(height: 10),
                // Botão responsavel pelo zoom
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => _zoom(false),
                    icon: Icon(Icons.remove, color: Colors.black87),
                    iconSize: 28,
                  ),
                ),
              ],
            ),
          ),

          // Área de confirmação da localização que clicamos
          if (_localizacaoSelecionada != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade800,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 20,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.orangeAccent,
                          size: 40,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Localização selecionada',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Lat: ${_localizacaoSelecionada!.latitude.toStringAsFixed(5)}\nLng: ${_localizacaoSelecionada!.longitude.toStringAsFixed(5)}',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, _localizacaoSelecionada);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle, size: 24),
                            SizedBox(width: 10),
                            Text(
                              'Confirmar Localização',
                              style: TextStyle(
                                fontSize: 18,
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
            ),
        ],
      ),
    );
  }

  void _atualizarMarcador(LatLng position) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId('destino'),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: 'Seu destino',
          snippet: 'Aqui será entregue sua pizza',
        ),
      ),
    );
  }

  Future<void> _irParaMinhaLocalizacao() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      LatLng minhaLocalizacao = LatLng(position.latitude, position.longitude);

      setState(() {
        _localizacaoSelecionada = minhaLocalizacao;
        _atualizarMarcador(minhaLocalizacao);
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(minhaLocalizacao, 16),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao obter localização: $e')),
      );
    }
  }

  void _zoom(bool zoomIn) {
    _mapController?.animateCamera(
      CameraUpdate.zoomBy(zoomIn ? 1 : -1),
    );
  }
}

class RastreamentoEntrega extends StatefulWidget {
  final List<Map<String, dynamic>> pizzasSelecionadas;

  const RastreamentoEntrega({Key? key, required this.pizzasSelecionadas}) : super(key: key);

  @override
  State<RastreamentoEntrega> createState() => _RastreamentoEntregaState();
}

class _RastreamentoEntregaState extends State<RastreamentoEntrega> {
  GoogleMapController? _mapController;
  LatLng? _localizacaoCliente;
  LatLng? _localizacaoEntregador;
  LatLng _localizacaoRestaurante = LatLng(-8.8383, 13.2344);

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  Timer? _timer;
  int _tempoEstimado = 25;
  double _distancia = 0;
  String _statusEntrega = "Preparando pedido";
  int _etapaAtual = 0;

  bool _localizacaoMarcada = false;

  // Para animação do entregador na rota, aquele ponto azul que se move em direção ao destino
  List<LatLng> _pontosRota = [];
  int _indexRotaAtual = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E1F1B),
      appBar: AppBar(
        title: Text(
          'Rastreamento de Entrega',
          style: TextStyle(color: Colors.orangeAccent),
        ),
        backgroundColor: Colors.brown.shade800,
      ),
      body: !_localizacaoMarcada
          ? _buildSelecaoLocalizacao()
          : _buildRastreamento(),
    );
  }

  Widget _buildSelecaoLocalizacao() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.orangeAccent.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_on,
                size: 100,
                color: Colors.orangeAccent,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Onde você está?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Precisamos saber sua localização para calcular o tempo de entrega e mostrar a rota',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 50),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _obterLocalizacaoAtual,
                icon: Icon(Icons.my_location, size: 28),
                label: Text(
                  'Usar Localização Atual',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
              ),
            ),

            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _abrirTelaSelecaoMapa,
                icon: Icon(Icons.map, size: 28),
                label: Text(
                  'Marcar no Mapa',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _abrirTelaSelecaoMapa() async {
    final LatLng? resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TelaSelecaoLocalizacao(),
      ),
    );

    if (resultado != null) {
      setState(() {
        _localizacaoCliente = resultado;
        _localizacaoMarcada = true;
        _iniciarRastreamento();
      });
    }
  }

  Future<void> _obterLocalizacaoAtual() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.deniedForever) {
        _mostrarErro("Permissão de localização negada permanentemente");
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _localizacaoCliente = LatLng(position.latitude, position.longitude);
        _localizacaoMarcada = true;
        _iniciarRastreamento();
      });
    } catch (e) {
      _mostrarErro("Erro ao obter localização: $e");
      // Usar localização de exemplo
      setState(() {
        _localizacaoCliente = LatLng(-8.8150, 13.2302);
        _localizacaoMarcada = true;
        _iniciarRastreamento();
      });
    }
  }

  void _iniciarRastreamento() {
    _calcularDistanciaETempo();
    _gerarRotaRealista();
    _adicionarMarcadores();
    _desenharRota();
    _iniciarSimulacaoEntrega();
  }

  void _calcularDistanciaETempo() {
    if (_localizacaoCliente == null) return;

    double distanciaMetros = Geolocator.distanceBetween(
      _localizacaoRestaurante.latitude,
      _localizacaoRestaurante.longitude,
      _localizacaoCliente!.latitude,
      _localizacaoCliente!.longitude,
    );

    setState(() {
      _distancia = distanciaMetros / 1000;
      _tempoEstimado = (_distancia * 3 + 15).round();
    });
  }

  void _gerarRotaRealista() {
    _pontosRota.clear();

    // Gera rota com curvas
    int numPontos = 50;

    for (int i = 0; i <= numPontos; i++) {
      double t = i / numPontos;

      double lat = _localizacaoRestaurante.latitude +
          (_localizacaoCliente!.latitude - _localizacaoRestaurante.latitude) * t;
      double lng = _localizacaoRestaurante.longitude +
          (_localizacaoCliente!.longitude - _localizacaoRestaurante.longitude) * t;

      // Adicionar curvas para simular ruas (padrão sinusoidal)
      double curva1 = sin(t * pi * 4) * 0.002;
      double curva2 = cos(t * pi * 3) * 0.0015;

      lat += curva1;
      lng += curva2;

      _pontosRota.add(LatLng(lat, lng));
    }
  }

  void _adicionarMarcadores() {
    _markers.clear();

    _markers.add(
      Marker(
        markerId: MarkerId('restaurante'),
        position: _localizacaoRestaurante,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
        infoWindow: InfoWindow(
          title: '🍕 Pizzaria',
          snippet: 'Preparando seu pedido',
        ),
      ),
    );

    // Cliente
    if (_localizacaoCliente != null) {
      _markers.add(
        Marker(
          markerId: MarkerId('cliente'),
          position: _localizacaoCliente!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(
            title: '🏠 Seu endereço',
            snippet: 'Destino da entrega',
          ),
        ),
      );
    }

    // Entregador
    if (_localizacaoEntregador != null) {
      _markers.add(
        Marker(
          markerId: MarkerId('entregador'),
          position: _localizacaoEntregador!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(
            title: '🛵 Entregador',
            snippet: _statusEntrega,
          ),
        ),
      );
    }
  }

  void _desenharRota() {
    _polylines.clear();
    _polylines.add(
      Polyline(
        polylineId: PolylineId('rota'),
        points: _pontosRota,
        color: Colors.blue,
        width: 5,
        patterns: [PatternItem.dash(20), PatternItem.gap(10)],
      ),
    );
  }

  void _iniciarSimulacaoEntrega() {
    _localizacaoEntregador = _localizacaoRestaurante;
    _indexRotaAtual = 0;

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      // Fase da preparação da entrega
      if (_etapaAtual == 0 && timer.tick > 10) {
        setState(() {
          _statusEntrega = "Saiu para entrega 🛵";
          _etapaAtual = 1;
        });
      }

      // Fase de movimento
      if (_etapaAtual == 1) {
        _moverEntregadorNaRota();

        if (_indexRotaAtual >= _pontosRota.length - 1) {
          setState(() {
            _statusEntrega = "Entregador chegou! 🎉";
            _etapaAtual = 2;
          });
          timer.cancel();
        }
      }
    });
  }

  void _moverEntregadorNaRota() {
    if (_indexRotaAtual < _pontosRota.length - 1) {
      setState(() {
        _indexRotaAtual++;
        _localizacaoEntregador = _pontosRota[_indexRotaAtual];

        double progressoRota = _indexRotaAtual / _pontosRota.length;
        _tempoEstimado = ((_distancia * 3) * (1 - progressoRota)).round() + 1;

        _adicionarMarcadores();
      });

      // Para que a camera possa seguir o entregador
      _mapController?.animateCamera(
        CameraUpdate.newLatLng(_localizacaoEntregador!),
      );
    }
  }

  void _mostrarErro(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: Colors.red.shade700,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  Widget _buildRastreamento() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.brown.shade700,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _statusEntrega,
                          style: TextStyle(
                            color: Colors.lightGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.straighten, color: Colors.white70, size: 16),
                            SizedBox(width: 5),
                            Text(
                              '${_distancia.toStringAsFixed(1)} km',
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          size: 35,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        Text(
                          '$_tempoEstimado min',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _localizacaoRestaurante,
              zoom: 13,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) {
              _mapController = controller;

              if (_localizacaoCliente != null) {
                LatLngBounds bounds = LatLngBounds(
                  southwest: LatLng(
                    min(_localizacaoRestaurante.latitude, _localizacaoCliente!.latitude) - 0.01,
                    min(_localizacaoRestaurante.longitude, _localizacaoCliente!.longitude) - 0.01,
                  ),
                  northeast: LatLng(
                    max(_localizacaoRestaurante.latitude, _localizacaoCliente!.latitude) + 0.01,
                    max(_localizacaoRestaurante.longitude, _localizacaoCliente!.longitude) + 0.01,
                  ),
                );

                Future.delayed(Duration(milliseconds: 500), () {
                  controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
                });
              }
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ),

        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.brown.shade800,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📦 Seu Pedido:',
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ...widget.pizzasSelecionadas.map((pizza) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 10),
              Divider(color: Colors.white30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}