/*
	Script destinado a localização de fontes
	
	A database de fontes fica na region FONT DB, altere conforme necessidade
	
	As funções que serão utilizadas estão presentes na region "Utils"
		
*/

enum FONTS {
	LATIN,
	CJK
}

global.font_db = [];

global.font_by_language = [];
global.font_by_language[LANGUAGES.ENGLISH] = FONTS.LATIN;
global.font_by_language[LANGUAGES.PORTUGUESE] = FONTS.LATIN;
//global.font_by_language[LANGUAGES.CHINESE_SIMPLIFIED] = FONTS.CJK;
//global.font_by_language[LANGUAGES.CHINESE_TRADITIONAL] = FONTS.CJK;
//global.font_by_language[LANGUAGES.JAPANESE] = FONTS.CJK;
//global.font_by_language[LANGUAGES.GERMAN] = FONTS.LATIN;
//global.font_by_language[LANGUAGES.FRENCH] = FONTS.LATIN;

#region FONT DB

function FontBuildGroupLatin() constructor
{
	wrap_word = false;
	
	interface_8 = fnt_noto_10;
	interface_10 = fnt_noto_10;
	interface_12 = fnt_noto_12;
	interface_14 = fnt_noto_14;
	interface_18 = fnt_noto_18;
}

function FontBuildGroupCjk() constructor
{
	wrap_word = true;
	
	interface_8 = fnt_noto_10
	interface_10 = fnt_noto_10;
	interface_12 = fnt_noto_12;
	interface_14 = fnt_noto_14;
	interface_18 = fnt_noto_18;
}

global.font_db[FONTS.LATIN] = new FontBuildGroupLatin();
global.font_db[FONTS.CJK]	= new FontBuildGroupCjk();

/*
	Como utilizar?
	Adicione fontes com uma KEY padrão que será utilizada em todos os grupos de fonte
	As keys devem seguir o padrão de nomeação snake_case
	Tenha certeza que as keys estejam presentes em todos os grupos de fontes
	Não utilizei um constructor unico para facilitar a leitura e manutenção caso possua muitas fontes diferentes
	
	Exemplo de novo grupo de fonte ->
		function FontBuildGroupCyrillic() constructor
		{
			interface_10 = fnt_cyryllic_10;
			...
		}
		global.font_db[FONTS.CYRILLIC] = new FontBuildGroupCyrillic();
*/

#endregion

#region Utils

/// @function						language_get_localized_font(_font, _language)
/// @description					Retorna uma fonte localizada para o idioma ativo
/// @param {string} _font			Key da fonte registrada na database de fontes
/// @param {real} [_language]		Idioma desejado utilizando o enum LANGUAGES, o padrão é o idioma ativo
/// @return {Asset.GMFont, string}	Retorna o asset da fonte pedida
function language_get_localized_font(_font, _language = settings_get_language())
{
	var _fnt_language = global.font_by_language[_language];		
	var _fnt_group = global.font_db[_fnt_language];
	var _localized_font = _font;
		
	var _check = struct_exists(_fnt_group, _font);
	if (_check)
	{
		_localized_font = _fnt_group[$ _font];
	}
		
	return _localized_font;
}

#endregion


/*
	Exemplo:
		var _font = language_get_localized_font("interface_10");
		draw_set_font(_font);
*/



