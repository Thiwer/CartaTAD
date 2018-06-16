with Ada.Text_IO; use Ada.Text_IO;
package body packageCarta is

   -- Vaciar la carta
   procedure carta_buida (c: out carta) is
      tc: t_carta renames c.c;
   begin
      -- Para cada una de las categorias lo limpiamos
      for x in tcategoria'Range loop
         tvacio(tc(x));
      end loop;

   end carta_buida;

   -- Introduce un plato en la carta
   procedure posar_element (c: in out carta; cat : in tcategoria; k: in tcodi; nom: in Unbounded_String) is
      tc: t_carta renames c.c;
      t : trie;
   begin
      -- Ya existe un plato con ese codigo
      if existe(tc(cat), k) then raise ya_existe; end if;
      poner(tc(cat), k, nom);
   end posar_element;

   -- Imprime todos los elementos de una categoria ordenados por codigo
   procedure imprimir_elements(c : in carta; cat : in tcategoria) is
      tc: t_carta renames c.c;
      it: iterator;
      elemento : Unbounded_String;
      i,j: Integer:=0;
   begin
      j:= 49;
      first(tc(cat), it);
      while is_valid(it) loop
         get(tc(cat), it, elemento);
         i:= Length(elemento) + 10;
         Put("*         - " & To_String(elemento));

         while i<j loop
            Put(" ");
            i:=i+1;
         end loop;

         Put_Line("*");

         next(tc(cat), it);
      end loop;


   end imprimir_elements;

   -- Elimina un plato de la carta
   procedure eliminar_element (c: in out carta; cat : in tcategoria; k: in tcodi) is
      tc: t_carta renames c.c;
   begin

      if not existe(tc(cat), k) then
         raise no_existe; -- No existe
      end if;

      borrar(tc(cat), k);

   end eliminar_element;

   -- Introduce un comentario
   procedure posar_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio; comentari : in Unbounded_String) is
      tc: t_carta renames c.c;
   begin

      poner_comentario_elemento(tc(cat), k, q, comentari);

   end posar_comentari;

   -- Devuelve un comentario
   function consulta_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) return Unbounded_String is
      comentari : Unbounded_String;
      tc: t_carta renames c.c;
   begin

      consultar_comentario_elemento(tc(cat), k, q, comentari);

      return comentari;

   end consulta_comentari;

   -- Existe un comentario
   function existeix_comentari(c : in carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio ) return Boolean is
      tc: t_carta renames c.c;
   begin

      return existe_comentario_elemento(tc(cat), k, q) ;

   end existeix_comentari;

   -- Elimina un comentario
   procedure eliminar_comentari (c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) is
      tc: t_carta renames c.c;
   begin

      borrar_comentario_elemento(tc(cat), k, q);

   end eliminar_comentari;

end packageCarta;
