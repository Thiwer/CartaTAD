with dcola;

with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
--
-- Esto es nuestro trie, que está dentro de una categoría
-- El trie tiene dos nodos diferentes, hoja e interior.
-- El interior es el array de abcedario, contendrá pnodos a otros interiores
-- La hoja es el propio Elemento que contendrá un nombre (unbounded) y array de qualificacions (tqualificacio)
--

generic
   -- key_codi y key_index los dejamos de tipo discreto por que
   -- se definirán cuando instanciemos el paquete tcaregoria
   -- desde carta.ads
   type key_codi is (<>);
   type key_index is range <>;
   type key is array(key_index) of key_codi;
   type tqualificacio is (<>);

package packageCategoria is

   type tipoNodo is (hoja, interior);
   type trie is limited private;

   mal_uso: exception;
   ya_existe: exception;
   no_existe: exception;
   espacio_desbordado: exception;

   procedure tvacio (t: out trie);
   function existe(t: in trie; k: in key) return boolean;
   procedure poner (t: in out trie; k: in key; x: in Unbounded_String);
   procedure borrar(t: in out trie; k: in key);

   -- Necesitamos estas funciones del Iterador para poder devolver la lista
   -- de elementos de la carta
   type iterator is limited private;
   procedure first (t: in trie; it: out iterator);
   procedure next (t: in trie; it: in out iterator);
   function is_valid (it: in iterator) return boolean;
   procedure get (t: in trie; it: in iterator; k: out key; x: out Unbounded_String);

   -- Estos métodos y funciones son para gestionar los comentarios de los elementos.
   -- Puesto que en Carta tenemos los métodos por donde nos llegarán los comentarios
   -- necesitamos gestionarlos desde nuestro trie (ya que el elemento final pertenece a este)
   procedure poner_comentario_elemento(t: in trie; k: in key; q : in tqualificacio; c: in Unbounded_String);
   procedure consultar_comentario_elemento(t: in trie; k: in key; q : in tqualificacio; c: out Unbounded_String);
   function existe_comentario_elemento(t: in trie; k: in key; q : in tqualificacio) return boolean;
   procedure borrar_comentario_elemento(t: in trie; k: in key; q : in tqualificacio);

private
   -- Necesitamos una cola para ir almancenado los comentarios que
   -- tendrá cada elemento. Cada elemento contendrá un array indexado
   -- por qualificacions (bo, mitja, dolent) donde cada una de las
   -- posiciones del array contendrá una cola de comentarios. De tal
   -- forma que los más antiguos serán los primeros es recuperarse


   type nodo;
   type pnodo is access nodo;

   -- Este array se utilizará para los nodos intermedios.
   -- Los cuales serán un array de pnodos donde cada posicion
   -- apuntará a otro nodo.
   type t_nodo is array(key_codi) of pnodo;

   package cat_cola is new dcola(elem => Unbounded_String);
   use cat_cola;
   -- Array indexado por claves, para los comentarios
   type qualificacions is array(tqualificacio) of cat_cola.cola;

   -- Tendremos dos tipos de nodos, los interiores y los hoja
   -- Los interiores serán un nuevo array de punteros
   -- Las hojas serán nuestros elementos que contendrán:
   -- 1. El nombre del elemento
   -- 2. Un array de comentarios indexado por qualificació
   type nodo(t: tipoNodo) is record
      case t is
         when hoja =>
            nombre: Unbounded_String;
            c: qualificacions;
         when interior =>
            ti: t_nodo;
      end case;
   end record;

   -- A la hora de devolver los elementos de una categoría, se usará
   -- un iterador para automatizar las consultas de los elementos.
   -- Contendrá pth, un array para ir almacenando la clave que recorremos
   -- Y luego i y k para saber en que punto del trie nos encontramos.
   type path is array (key_index) of pnodo;
   type iterator is record
      pth : path;
      k : key;
      i : key_index;
   end record;

   type trie is
      record
         raiz: pnodo;
      end record;

   --type categoria is array(tcategoria) of trie;

end packageCategoria;
