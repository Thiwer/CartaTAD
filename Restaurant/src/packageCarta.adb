package body packageCarta is

   -- Vaciar la carta
   procedure carta_buida (c: out carta) is
      tc: t_carta renames c.c;
      t : trie;
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

         t := tc(cat);

      if existe(t, k) then
         raise mal_uso; -- Ya existe un plato con ese codigo
      end if;

      poner(t, k, nom);

   end posar_element;

   -- Imprime todos los elementos de una categoria ordenados por codigo
   procedure imprimir_elements(c : in carta; cat : in tcategoria) is
   begin
      null;
   end imprimir_elements;

   -- Elimina un plato de la carta
   procedure eliminar_element (c: in out carta; cat : in tcategoria; k: in tcodi) is
      t: trie;
   begin

      t := c(cat);

      borrar(t, k);

   end eliminar_element;

   -- Introduce un comentario
   procedure posar_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio; comentari : in Unbounded_String) is
      t: trie;
   begin

      t := c(cat);

      if existe_comentario_elemento(t, k, q) then
         raise mal_uso;
      end if;

      poner_comentario_elemento(t, k, q, comentari);

   end posar_comentari;

   -- Devuelve un comentario
   function consulta_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) return Unbounded_String is
      t: trie;
      comentari : Unbounded_String;
   begin

      t := c(cat);

      if not existe_comentario_elemento(t, k, q) then
         raise mal_uso;
      end if;

      consultar_comentario_elemento(t, k, q, comentari);

      return comentari;

   end consulta_comentari;

   -- Existe un comentario
   function existeix_comentari(c : in carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio ) return Boolean is
      t: trie;
   begin

      t := c(cat);

      return existe_comentario_elemento(t, k, q) ;

   end existeix_comentari;

   -- Elimina un comentario
   procedure eliminar_comentari (c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) is
      t: trie;
   begin

      t := c(cat);

      if not existe_comentario_elemento(t, k, q) then
         raise mal_uso;
      end if;

      borrar_comentario_elemento(t, k, q);

   end eliminar_comentari;

end packageCarta;
