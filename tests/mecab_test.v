import mecab

fn test_tagged_result() ! {
	input := "太郎は次郎が持っている本を花子に渡した。"
	m := mecab.MeCab.new()!
	result := m.parse_str_tostr(input)!
	println(input)
	println(result)
}
