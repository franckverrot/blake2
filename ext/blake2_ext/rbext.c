#include <ruby/ruby.h>
#include <ruby/encoding.h>
#include "blake2.h"

typedef struct {
  uint8_t key_length;
  uint8_t *key_bytes;

  uint8_t output_length;
  uint8_t *output;

  VALUE to_hex;
  VALUE to_bytes;
} Blake2;

VALUE cBlake2;

static void blake2_free(Blake2 *blake2) {
  if(blake2->key_length > 0) {
    ruby_xfree(blake2->key_bytes);
  }

  if(blake2->output_length > 0) {
    ruby_xfree(blake2->output);
  }
}

VALUE blake2_alloc(VALUE klass) {
  VALUE blake2_obj = ruby_xmalloc(sizeof(Blake2));

  return Data_Wrap_Struct(klass, NULL, blake2_free, blake2_obj);
}

VALUE m_blake2_initialize(VALUE self, VALUE _len, VALUE _key) {
  Blake2 *blake2;
  Data_Get_Struct(self, Blake2, blake2);
  int i;

  ID bytes_method  = rb_intern("bytes");
  blake2->to_hex   = ID2SYM(rb_intern("to_hex"));
  blake2->to_bytes = ID2SYM(rb_intern("to_bytes"));

  VALUE key_bytes_ary = rb_funcall(_key, bytes_method, 0);
  blake2->key_length  = RARRAY_LEN(key_bytes_ary);
  blake2->key_bytes   = (uint8_t*)ruby_xmalloc(blake2->key_length * sizeof(uint8_t));

  for(i = 0; i < blake2->key_length; i++) {
    VALUE byte           = rb_ary_entry(key_bytes_ary, i);
    blake2->key_bytes[i] = NUM2INT(byte);
  }

  blake2->output_length = NUM2INT(_len);
  blake2->output        = (uint8_t*)ruby_xmalloc(blake2->output_length * sizeof(uint8_t));

  return Qnil;
}


VALUE m_blake2_digest(VALUE self, VALUE _input, VALUE _representation) {
  Blake2 *blake2;

  char * input     = RSTRING_PTR(_input);
  int input_length = RSTRING_LEN(_input);
  int i;

  Data_Get_Struct(self, Blake2, blake2);

  blake2s(blake2->output, input, blake2->key_bytes,
      blake2->output_length, input_length, blake2->key_length);

  VALUE result;

  if(_representation == blake2->to_bytes) {
    result = rb_ary_new2(blake2->output_length);

    for(i = 0; i < blake2->output_length; i++) {
      rb_ary_push(result, INT2NUM(blake2->output[i]));
    }

    return result;
  } else if(_representation == blake2->to_hex) {
    char * c_str = (char*)ruby_xmalloc(blake2->output_length * sizeof(char) * 2);

    for(i = 0; i < blake2->output_length; i++) {
      sprintf(c_str + (i * 2), "%02x", blake2->output[i]);
    }

    result = rb_str_new2(c_str);

    ruby_xfree(c_str);

    return result;
  } else {
    rb_raise(rb_eArgError, "Unknown representation", _representation);
  }
}

void Init_blake2_ext() {
  cBlake2 = rb_define_class("Blake2", rb_cObject);
  rb_define_alloc_func(cBlake2, blake2_alloc);

  rb_define_private_method(cBlake2, "initialize", RUBY_METHOD_FUNC(m_blake2_initialize), 2);
  rb_define_method(cBlake2, "digest", RUBY_METHOD_FUNC(m_blake2_digest), 2);
}
