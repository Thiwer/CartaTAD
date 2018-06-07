--
-- Esto es nuestro trie, que está dentro de una categoría
-- El trie tiene dos nodos diferentes, hoja e interior.
-- El interior es el array de abcedario, contendrá pnodos a otros interiores
-- La hoja es el propio Elemento que contendrá un nombre (unbounded) y array de qualificacions (tqualificacio)
--

generic 
    type tipoNodo is (hoja, interior);
package tcategoria is

    type categoria is limited private;

    package cat_cola is new tqualificacio(elem => Unbounded_String);
    use cat_cola;

    package cat_elemento is new telement(elem => Unbounded_String, elem_cola => cat_cola);
    use cat_elemento;

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
    pragma pack(categoria); -- obliga a usar el m�nimo espacio de memoria para
                        -- guardar el tipo

    type t_pointers is array (natural range 0 .. max_int) of pnodo;
    type t_keys is array (natural range 1 .. max_int) of key;

    type nodo;
    type pnodo is access nodo;
    type nodo(t: tipoNodo) is 
        record
            case t is
                when hoja => e: cat_elemento;
                when interior => tk: t_keys;
                                 tp: t_pointers;
            end case;
        end record;

    type categoria is 
        record
            raiz: pnodo;
        end record;
end tcategoria;
