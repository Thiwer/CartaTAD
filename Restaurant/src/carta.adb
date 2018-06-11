package body carta is
   
   -- Vaciar la carta
   procedure carta_buida (c: out carta) is
   begin
      
   end carta_buida;
   
   -- Introduce un plato en la carta
   procedure posar_element (c: in out carta; cat : in tcategoria; k: in tcodi; nom: in Unbounded_String) is
   begin
      
   end posar_element;
   
   -- Imprime todos los elementos de una categoria ordenados por codigo
   procedure imprimir_elements(c : in carta; cat : in tcategoria) is
   begin
      
   end imprimir_elements;
   
   -- Elimina un plato de la carta
   procedure eliminar_element (c: in out carta; cat : in tcategoria; k: in tcodi) is
   begin
      
   end eliminar_element;
   
   -- Introduce un comentario
   procedure posar_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio; comentari : in Unbounded_String) is
   begin
      
   end posar_comentari;
   
   -- Devuelve un comentario
   function consulta_comentari(c : in out carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio) is
   begin
      
   end consulta_comentari;
   
   -- Existe un comentario
   function existeix_comentari(c : in carta; cat : in tcategoria; k : in tcodi; q : in tqualificacio )is
   begin
      
   end existeix_comentari;
   
   -- Elimina un comentario
   procedure eliminar_comentari (c : in out carta; cat : in tcategoria; k : in tcodi; cal : in tqualificacio) is
   begin
      
   end eliminar_comentari;   

end carta;
