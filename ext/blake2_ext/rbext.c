#include <ruby/ruby.h>
#include <ruby/encoding.h>
#include "blake2.h"

typedef struct {
  uint8_t key_length;
  uint8_t *key;

  uint8_t output_length;
  uint8_t *output;
} Blake2;

void _hexdump(char * data, int len)
{
  int i;
  for (i = 0; i < len; i++) {
    printf("%02X", (unsigned char)data[i]);
  }
  printf("\n");
}

static void blake2_free(Blake2 *blake2) {
  rb_gc_mark(blake2->key);
}

static VALUE blake2_alloc(VALUE klass) {
    return Data_Wrap_Struct(klass, NULL, blake2_free, ruby_xmalloc(sizeof(Blake2)));
}

VALUE m_blake2_initialize(VALUE self, VALUE _len, VALUE _key) {
      Blake2 *blake2;
      Data_Get_Struct(self, Blake2, blake2);

      blake2->key           = _key;
      blake2->output_length = NUM2INT(_len);
      blake2->output        = (uint8_t*)ruby_xmalloc(blake2->output_length * sizeof(uint8_t));

      return Qnil;
}

VALUE m_blake2_digest(VALUE self, VALUE _input, VALUE _representation) {
  Blake2 *blake2;

  VALUE to_hex   = ID2SYM(rb_intern("to_hex"));
  VALUE to_bytes = ID2SYM(rb_intern("to_bytes"));

  char * input = RSTRING_PTR(_input);
  int input_length = RSTRING_LEN(_input);

  Data_Get_Struct(self, Blake2, blake2);

  ID bytes_method = rb_intern("bytes");
  VALUE bytes_ary = rb_funcall(blake2->key, bytes_method, 0);
  int key_len = RARRAY_LEN(bytes_ary);

  uint8_t * key_bytes = (uint8_t*)ruby_xmalloc(key_len * sizeof(uint8_t));
  for(int i = 0; i < key_len; i++) {
    VALUE byte = rb_ary_entry(bytes_ary, i);
    key_bytes[i] = NUM2INT(byte);
  }

  blake2s(blake2->output, input, key_bytes,
      blake2->output_length, input_length, key_len);

  if(_representation == to_bytes) {
    VALUE result = rb_ary_new2(blake2->output_length);

    for(int i = 0; i < blake2->output_length; i++) {
      rb_ary_push(result, INT2NUM(blake2->output[i]));
    }

    return result;
  } else if(_representation == to_hex) {
    char * c_str = (char*)ruby_xmalloc(blake2->output_length * sizeof(char) * 2);

    for(int i = 0; i < blake2->output_length; i++) {
      sprintf(c_str + (i * 2), "%02x", blake2->output[i]);
    }
    return rb_str_new2(c_str);
  } else {
    rb_raise(rb_eArgError, "Unknown representation", _representation);
  }
}
void Init_blake2_ext() {
  VALUE blake2 = rb_define_class("Blake2", rb_cObject);
  rb_define_alloc_func(blake2, blake2_alloc);

  rb_define_private_method(blake2 , "initialize", RUBY_METHOD_FUNC(m_blake2_initialize), 2);
  rb_define_method(blake2 , "digest", RUBY_METHOD_FUNC(m_blake2_digest), 2);
}
