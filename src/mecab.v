module mecab

import os

#include <mecab.h>
#flag linux -L/usr/lib -lmecab -lstdc++

struct C.mecab_t {}

fn C.mecab_new(i32, &&u8) &C.mecab_t

fn C.mecab_strerror(&C.mecab_t) &u8

fn C.mecab_destroy(&C.mecab_t)

fn C.mecab_sparse_tostr2(&C.mecab_t, &u8, usize) &u8

pub struct MeCab {
	mecab &C.mecab_t
}

fn (m MeCab) strerror() string {
	e := C.mecab_strerror(m.mecab)
	return unsafe { tos_clone(e) }
}

// create new MeCab tagger object
pub fn MeCab.new() !MeCab {
	args := os.args.map(it.str)
	m := MeCab{C.mecab_new(args.len, &args[0])}
	if isnil(m.mecab) {
		return error(m.strerror())
	}
	return m
}

@[unsafe]
pub fn (m &MeCab) free() {
	C.mecab_destroy(m.mecab)
}

pub fn (m MeCab) parse_str_tostr(s string) !string {
	ret := C.mecab_sparse_tostr2(m.mecab, s.str, s.len)
	if isnil(ret) {
		return error(m.strerror())
	}
	return unsafe { tos_clone(ret) }
}
