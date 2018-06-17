with packageCarta;
use packageCarta;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

procedure Restaurant is
   type temporada is (OtonoInvierno, PrimaveraVerano);
   c: carta;
   key: tcodi;

   procedure inicializar_carta_otono_invierno(c: in out carta) is
      k: tcodi;
      plato: Unbounded_String;
      coBueno, coBueno2, coMedio, coMedio2, coMalo, coMalo2: Unbounded_String;
   begin
      coBueno:= To_Unbounded_String("Esta riquisimo");
      coMedio:= To_Unbounded_String("Podria estar mejor");
      coMalo:= To_Unbounded_String("No lo volvere a pedir nunca");

      -- Codigos de los platos y bebidas de la temporada otono/invierno
      k(1..11) := "CHIPIRONES@";
      plato := to_unbounded_string("Chipirones del mar");
      posar_element (c, Entrant, k, plato);
      posar_comentari (c, Entrant, k, Bo, coBueno);
      posar_comentari (c, Entrant, k, Dolent, coMalo);
      posar_comentari (c, Entrant, k, Mitja, coMedio);

      k(1..7) := "ALIOLI@";
      plato:= to_unbounded_string("Pan con alioli");
      posar_element (c, Entrant, k, plato);
      posar_comentari (c, Entrant, k, Dolent, coMalo);
      posar_comentari (c, Entrant, k, Mitja, coMedio);

      k(1..10) := "ACEITUNAS@";
      plato:= to_unbounded_string("Aceitunas sevillanas");
      posar_element (c, Entrant, k, plato);
      posar_comentari (c, Entrant, k, Mitja, coMedio);

      k(1..10) := "CROQUETAS@";
      plato:= to_unbounded_string("Croquetas caseras de jamon");
      posar_element (c, Entrant, k, plato);
      posar_comentari (c, Entrant, k, Mitja, coMalo);

      k(1..6) := "JAMON@";
      plato:= to_unbounded_string("Racion de jamon iberico");
      posar_element (c, Entrant, k, plato);
      posar_comentari (c, Entrant, k, Mitja, coMalo);

      k(1..9) := "ENSALADA@";
      plato:= to_unbounded_string("Ensalada Cesar");
      posar_element (c, Primer, k, plato);

      k(1..5) := "SOPA@";
      plato:= to_unbounded_string("Sopa de Navidad");
      posar_element (c, Primer, k, plato);

      k(1..8) := "SCALOPE@";
      plato:= to_unbounded_string("Scalope de lomo");
      posar_element (c, Primer, k, plato);

      k(1..8) := "NUGGETS@";
      plato:= to_unbounded_string("Nuggets de pollo");
      posar_element (c, Primer, k, plato);

      k(1..9) := "ROLLITOS@";
      plato:= to_unbounded_string("Rollitos de primavera");
      posar_element (c, Primer, k, plato);

      k(1..7) := "DORADA@";
      plato:= to_unbounded_string("Dorada a la plancha");
      posar_element (c, Segon, k, plato);

      k(1..9) := "ENTRCOTE@";
      plato:= to_unbounded_string("Entrecote de ternera a la piedra");
      posar_element (c, Segon, k, plato);

      k(1..6) := "ASADO@";
      plato:= to_unbounded_string("Asado de tira");
      posar_element (c, Segon, k, plato);

      k(1..12) := "PIMARGARITA@";
      plato:= to_unbounded_string("Pizza Margarita");
      posar_element (c, Segon, k, plato);

      k(1..15) := "PICUATROQUESOS@";
      plato:= to_unbounded_string("Pizza 4 Quesos");
      posar_element (c, Segon, k, plato);

      k(1..11) := "PIHAWAIANA@";
      plato:= to_unbounded_string("Pizza Hawaiana");
      posar_element (c, Segon, k, plato);

      k(1..5) := "CAFE@";
      plato:= to_unbounded_string("Cafe");
      posar_element (c, Postres, k, plato);

      k(1..9) := "SANTIAGO@";
      plato:= to_unbounded_string("Tarta de Santiago");
      posar_element (c, Postres, k, plato);

      k(1..8) := "COULAND@";
      plato:= to_unbounded_string("Couland de chocolate");
      posar_element (c, Postres, k, plato);

      k(1..6) := "FRUTA@";
      plato:= to_unbounded_string("Fruta de temporada");
      posar_element (c, Postres, k, plato);

      k(1..5) := "AGUA@";
      plato:= to_unbounded_string("Agua 500ml");
      posar_element (c, Begudes, k, plato);

      k(1..8) := "CERVEZA@";
      plato:= to_unbounded_string("Estrella Galicia");
      posar_element (c, Begudes, k, plato);

      k(1..9) := "COCACOLA@";
      plato:= to_unbounded_string("Coca Cola");
      posar_element (c, Begudes, k, plato);

      k(1..7) := "FANTAN@";
      plato:= to_unbounded_string("Fanta Naranja");
      posar_element (c, Begudes, k, plato);
   end inicializar_carta_otono_invierno;

   procedure cambiar_carta_primavera_verano(c: in out carta) is
      k: tcodi;
      plato: Unbounded_String;
      coBueno, coMedio, coMalo: Unbounded_String;
   begin
      -- Quitamos dos primeros de la carta de invierno
      Put_Line(""); Put_Line("Cambiando Primeros");
      k(1..5) := "SOPA@"; eliminar_element(c, Primer, k);
      k(1..9) := "ROLLITOS@"; eliminar_element(c, Primer, k);

      -- Ahora insertamos dos primero diferentes
      k(1..10) := "SALMOREJO@";
      plato:= to_unbounded_string("Salmorejo con jamon");
      posar_element (c, Primer, k, plato);

      k(1..7) := "GYOZAS@";
      plato:= to_unbounded_string("Racion de Gyozas");
      posar_element (c, Primer, k, plato);
      Put_Line("");

      -- Quitamos dos segundos de la carta de invierno
      Put_Line(""); Put_Line("Cambiando Segundos");
      k(1..6) := "ASADO@"; eliminar_element(c, Segon, k);
      k(1..7) := "DORADA@"; eliminar_element(c, Segon, k);
      k(1..9) := "ENTRCOTE@"; eliminar_element(c, Segon, k);

      -- Ahora insertamos 2 segundos diferentes
      k(1..8) := "LECHONA@";
      plato:= to_unbounded_string("Lechona al horno");
      posar_element (c, Segon, k, plato);

      k(1..7) := "PAELLA@";
      plato:= to_unbounded_string("Paella mixta");
      posar_element (c, Segon, k, plato);
      Put_Line("");

      Put_Line(""); Put_Line("Cambiando Postres");
      k(1..8) := "COULAND@"; eliminar_element(c, Postres, k);
      k(1..7) := "HELADO@";
      plato:= to_unbounded_string("Helado de diferentes sabores");
      posar_element (c, Postres, k, plato);
      Put_Line("");
   end cambiar_carta_primavera_verano;

   procedure imprimir_carta (c: in carta; t: in temporada) is
   begin
      Put_Line(""); Put_Line("");

      Put_Line("****************************************************");
      Put_Line("**********                               ***********");

      if t = OtonoInvierno then
         Put_Line("**********     CARTA OTONO-INVIERNO:     ***********");
      elsif t = PrimaveraVerano then
         Put_Line("**********    CARTA PRIMAVERA-VERANO:    ***********");
      end if;

      Put_Line("**********                               ***********");
      Put_Line("****************************************************");
      Put_Line("*                                                  *");
      Put_Line("*                  1. ENTRANTES                    *");
      imprimir_elements(c, Entrant);

      Put_Line("*                                                  *");
      Put_Line("*                  2. PRIMEROS                     *");
      imprimir_elements(c, Primer);

      Put_Line("*                                                  *");
      Put_Line("*                  3. SEGUNDOS                     *");
      imprimir_elements(c, Segon);

      Put_Line("*                                                  *");
      Put_Line("*                  4. POSTRES                      *");
      imprimir_elements(c, Postres);

      Put_Line("*                                                  *");
      Put_Line("*                  5. BEBIDAS                      *");
      imprimir_elements(c, Begudes);
      Put_Line("*                                                  *");
      Put_Line("*                                                  *");
      Put_Line("****************************************************");
   end imprimir_carta;

   procedure imprimir_comentario_plato(c: in out carta; cat: in tcategoria; k: in tcodi) is
      cBueno, cMedio, cMalo: boolean:=false;
   begin
      cBueno := existeix_comentari(c, cat, k, Bo);
      if cBueno then Put_Line("Primer comentario bueno: " & To_String(consulta_comentari (c, cat, k, Bo))); end if;

      cMedio := existeix_comentari(c, cat, k, Mitja);
      if cMedio then Put_Line("Primer comentario medio: " & To_String(consulta_comentari (c, cat, k, Mitja))); end if;

      cMalo := existeix_comentari(c, cat, k, Dolent);
      if cMalo then Put_Line("Primer comentario malo: " & To_String(consulta_comentari (c, cat, k, Dolent))); end if;

      if not cMalo and not cMedio and not cBueno then Put_Line("Este plato no tiene comentarios."); end if;
   end imprimir_comentario_plato;
begin
   -- Hemos creado procedimientos auxiliares por tal de dejar el main más lejible

   -- Primero de todo inicializamos la carta, dejamos vacíos todos las posiciones del array
   -- Con esto usamos el carta_buida();
   carta_buida(c);

   -- Inicializamos la carta de de otoño-invierno,
   -- Insertamos los platos por categoría y algunos comentarios a sus platos
   -- por calificaciones.
   -- Con esto usamos el posar_element() y posar_comentari();
   inicializar_carta_otono_invierno(c);

   -- Ahora hacemos la impresión de la carta.
   -- Con esto usamos el imprimir_elements()
   imprimir_carta(c, OtonoInvierno);

   -- Hemos creado el procedimiento auxiliar imprimir_comentario_plato() para
   -- Dada una clave, imprimimos el comentario más antiguo de cada calificación
   -- Para eso nos ayudamos de la función existeix_comentari() para saber si
   -- hay algún comentario de una calificación. Si lo hay se imprime.
   -- Con esto usamos el existeix_comentari() y consulta_comentari();
   key(1..11) := "CHIPIRONES@";
   Put_Line(""); Put_Line("");
   Put_Line("Consultamos comentarios para el Entrante CHIPIRONES");
   Put_Line("");
   imprimir_comentario_plato(c, Entrant, key);

   -- Ahora eliminamos un comentario del plato anterior,
   -- en este caso el comentario malo
   -- Con esto usamos el eliminar_comentari()
   Put_Line("");
   Put_Line("Eliminamos comentario Malo para el Entrante CHIPIRONES");
   eliminar_comentari(c, Entrant, key, Dolent);

   -- Ahora consultamos los comentarios de nuevo para verificar que se ha
   -- eliminado bien.
   Put_Line("");
   Put_Line("Consultamos de nuevo comentarios para el Entrante CHIPIRONES");
   Put_Line("");
   imprimir_comentario_plato(c, Entrant, key);
   Put_Line(""); Put_Line("");

   -- Con este procedimiento eliminamos algunos platos de la carta y además
   -- insertamos otros. Otros elementos los dejamos por que pueden ser de
   -- cualquier temportada
   -- Con esto usamos eliminar_element() y posar_element()
   cambiar_carta_primavera_verano(c);

   -- Volvemos a imprimira la carta, esta vez la de primavera-verano
   imprimir_carta(c, PrimaveraVerano);
exception
   when Constraint_Error => Put_Line("Se ha producido un error con la carta, por favor, consulte con el metre");
   when packageCarta.mal_uso => Put_Line("Mal uso");
   when packageCarta.no_existe => Put_Line("El plato no esta disponible");
   when packageCarta.ya_existe => Put_Line("El plato ya esta en la carta");
   when packageCarta.espacio_desbordado => Put_Line("No queda espacio.");
end Restaurant;
