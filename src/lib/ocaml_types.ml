type field_type = 
  | String 
  | Float 
  | Int 
  | Bytes
  | Bool
  | User_defined_type of string 

type field_name = string 

type type_qualifier = 
  | No_qualifier
  | Option
  | List 

(** the field is parametrized by the encoding_type with could either 
    [field_encoding] or [record_encoding_type] depending 
    if the field is used in a variant or record type
 *) 
type 'a afield = {
  field_type : field_type; 
  field_name : field_name; 
  type_qualifier : type_qualifier; 
  encoding_type : 'a;
}

type 'a avariant= {
  variant_name : string; 
  constructors : 'a list;
}

type const_variant_constructor = string * int  

type const_variant = const_variant_constructor avariant 

type variant_constructor = Encoding_util.field_encoding afield 

type variant = variant_constructor avariant 

type record_encoding_type = 
  | Regular_field of Encoding_util.field_encoding
  | One_of        of variant  

type record = {
  record_name: string; 
  fields : record_encoding_type afield list; 
}

type type_ = 
  | Record of record 
  | Variant of variant
  | Const_variant  of const_variant 