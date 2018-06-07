type elem is (<>); -- tipo discreto

package tcategoria is

   type categoria is limited private;

   ya_existe: exception;
   no_existe: exception;
   espacio_desbordado: exception;

   procedure cvacio (s: out categoria);
   procedure poner (s: in out categoria; k: in key; x: in item);
   procedure consultar(s: in categoria; k: in key; x: out item);
   procedure borrar(s: in out categoria; k: in key);
   procedure actualiza(s: in out categoria; k: in key; x: in item);
private
   type categoria is array(elem) of boolean;
   pragma pack(categoria); -- obliga a usar el mínimo espacio de memoria para
                        -- guardar el tipo
end tcategoria;
