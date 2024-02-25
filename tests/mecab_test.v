import mecab

fn test_tagged_result() ! {
	input := "太郎は次郎が持っている本を花子に渡した。"
	m := mecab.MeCab.new()!
	result := m.parse_str_tostr(input)!
	println(input)
	println(result)
	result2 := m.nbest_parse_str_tostr(3, input)!
	println(result2)
}
