package carta is

   type key_component is (<>); -- tipo discreto componentes
   type key_index is range <>; -- rango de enteros, indice sobre la clave
   type key is array(key_index) of key_component;

   espacio_desbordado: exception;

   procedure carta_buida (s: out carta);
   -- Introduce un plato en la carta
   procedure posar_element (c: in out carta; cat : in tcategoria; k: in tcodi; nom: in Unbounded_String);
   -- Imprime todos los elementos de una categoria ordenados por codigo
   procedure imprimir_elements(c : in carta; cat : in tcategoria);
   -- Elimina un plato de la carta
   procedure eliminar_element (c: in out carta; cat : in tcategoria; k: in tcodi);
   -- Introduce un comentario
   procedure posar_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio; comentari : in Unbounded_String);
   -- Devuelve un comentario
   function consulta_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) return Unbounded_String);
   -- Existe un comentario
   function existeix_comentari(c : in carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) return Boolean;
   -- Elimina un comentario
   procedure eliminar_comentari (c : in out carta; cat : in tcategoria; k : in tcodi; cal : in tqualificacio) ;

   -- function existe (s: in carta; x: in elem) return boolean;
   -- function esta_buida(s: in carta) return boolean;



private
   type nodo;
   type pnodo is access nodo;
type nodo is array(key_component) of pnodo;
   type carta is
      record
         raiz: pnodo;
      end record;
end carta;
