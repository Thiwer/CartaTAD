--
-- Esto es nuestro elemento, es decir, los nodos hoja de tcategoria apuntant a estos elementos
-- Estos contienen el nombre del plato y un array de comentarios indexado por qualificacions
--

generic 
    type tipoQualificacio is (bo, mitja, dolent);
package telement is
    
    package elem_cola is new dcola(elem => Unbounded_String);
    use elem_cola;

    ya_existe: exception;
    no_existe: exception;
    espacio_desbordado: exception;

    procedure cvacio (s: out categoria);
    procedure poner (s: in out categoria; k: in key; x: in item);
    procedure consultar(s: in categoria; k: in key; x: out item);
    procedure borrar(s: in out categoria; k: in key);
    procedure actualiza(s: in out categoria; k: in key; x: in item);
private
    type t_qualificacions is array(tipoQualificacio) of elem_cola;

    type nodo;
    type pnodo is access nodo;
    type nodo() is 
        record
            nom: Unbounded_String;
            q: t_qualificacions; -- array indexado por tipoQualificacio y
                                 -- que contiene elem_cola, que son colas de comentarios (Unbounded_String)
        end record;

    type categoria is 
        record
            raiz: pnodo;
        end record;
end tcategoria;
