/*
	Script destinado a localização de idiomas utilizando um arquivo TSV
	
	As funções relacioandas a leitura de arquivo estão na region "Text System Functions"
	não é recomendável modifica-las a não ser que seja necessário.
	
	As funções que serão utilizadas estão presentes na region "Utils"
	
	A região "Building database and systems" apenas chama as funções para construir sistema, não altere as chamadas.	
*/

// Localization System Variables
enum LANGUAGES {
	PORTUGUESE,
	ENGLISH,
	//CHINESE_SIMPLIFIED,
	//CHINESE_TRADITIONAL,
	//JAPANESE,
	//GERMAN,
	//FRENCH,
	LENGTH
}

// Languages tags
global.language_tags[LANGUAGES.PORTUGUESE] = "pt";
global.language_tags[LANGUAGES.ENGLISH] = "en";
//global.language_tags[LANGUAGES.CHINESE_SIMPLIFIED] = "zh_Hans";
//global.language_tags[LANGUAGES.CHINESE_TRADITIONAL] = "zh_Hant";
//global.language_tags[LANGUAGES.JAPANESE] = "ja";
//global.language_tags[LANGUAGES.GERMAN] = "de";
//global.language_tags[LANGUAGES.FRENCH] = "fr";
//global.language_tags[LANGUAGES.CHINESE_SIMPLIFIED] = "zh_Hans";

// Text Dictionary
global.language_text_dict = {}

// Files
global.language_file_name = "languages.tsv";
global.language_file_path = $"{global.language_file_name}";

#region Text/File System Functions
// Essas funções são utilizadas pelo próprio sistema, cuidado ao alterar ou chamar em outros contextos

#region String replace
	// Strings to be replaced when loading localization file
	global.__char_library = [];
	
	// String replacement struct
	function StringBuildStringReplacement(_key, _char) constructor
	{
		key = _key;
		char = _char;
	}
	
	// Add string replacement to lib
	function string_add_replacement_lib(_key, _char)
	{
		if (string_length(_key) > 0 && string_length(_char) > 0){
			var _replace = new StringBuildStringReplacement(_key, _char);
			array_push(global.__char_library, _replace);
		}
	}

	// Checa por strings predeterminadas que devem ser substituidas do arquivo original para o texto que será utilizado na engine
	function string_replace_internal(_source_string, _target_string, _replacement_string) 
	{
	    // Initialize the new string with the original (before any replacements)
	    var _new_string = _source_string;
    
	    // Loop through each character of the source string
	    for (var _i = 1; _i <= string_length(_source_string); _i++) 
	    {
	        // Check if the current character matches the first character of the target substring
	        if (string_char_at(_source_string, _i) == string_char_at(_target_string, 1)) 
	        {
	            var _replace = true; // Flag to determine if we can perform a replacement
            
	            // Loop to check if the entire target string matches at this position in the source string
	            for (var _j = 1; _j <= string_length(_target_string); _j++) 
	            {
	                // If any character does not match, cancel the replacement
	                if (string_char_at(_source_string, _j + _i - 1) != string_char_at(_target_string, _j)) 
	                {
	                    _replace = false; // Set the flag to false if the match fails
	                }
	            }
            
	            // If the full target substring is found at the current position
	            if (_replace) 
	            {
	                // Create the new string:
	                // - Copy the part before the target substring
	                // - Replace the target substring with the replacement string
	                // - Copy the part after the target substring
	                _new_string = string_copy(_source_string, 1, _i - 1) + _replacement_string + string_copy(_source_string, _i + _j - 1, string_length(_source_string));
                
	                // Recursively call the function to replace any remaining occurrences
	                return string_replace_internal(_new_string, _target_string, _replacement_string);
	            }
	        }
	    }
    
	    // Return the final string after all replacements are done
	    return _new_string;
	}
	
	// Strings to be added to DB
	string_add_replacement_lib("\\n", "\n");
	
#endregion

// Carrega o arquivo de linguagens para a estrutura a ser usada na engine
function __language_load_tsv_file(_file_name = global.language_file_path)
{ 	
    // Open the specified file for reading
    var _file = file_text_open_read(_file_name); 	 
    var _lines = [];
    
	if (!_file){
		show_debug_message("Localization file does not exists");
		exit;
	}
	
    // Loop until the end of the file is reached, reading each line
    while (!file_text_eof(_file)) 
    {
        // Add each line from the file to the _lines array
        array_push(_lines, file_text_read_string(_file));
        file_text_readln(_file); // Move to the next line
    }
    
    // Close the file after reading all the lines
    file_text_close(_file);
    var _array = [];
    
    // Loop through each line that was read from the file
    for (var _i = 0; _i < array_length(_lines); _i++) 
    {
        // Initialize a new sub-array for each line
        _array[_i] = [];
        var _index = 0;
        _array[_i][_index] = "";
        
        // Loop through each character in the current line
        for (var _j = 1; _j <= string_length(_lines[_i]); _j++) 
        {
            var _char = string_char_at(_lines[_i], _j);
            
            // If a tab character is found, move to the next "column" in the array
            if (_char == "	") 
            {  
                _index++;
                _array[_i][_index] = "";
            } 
            else 
            { 
                // Otherwise, append the character to the current string in the array
                _array[_i][_index] += string_copy(_lines[_i], _j, 1);
            }
        }
    }
    
    var _struct = {};
    
    // Loop through each line (row) in the _array
    for (var _i = 0; _i < array_length(_array); _i++) 
    {  		
        // Create a new entry in the _struct object using the first column as the key
        _struct[$ _array[_i][0]] = {};
        
        // Loop through each "column" of the current row (starting from column 1)
        for (var _j = 1; _j < array_length(_array[_i]); _j++) 
        {
            var _str = _array[_i][_j];
            
            // Check the global character library and replace any special sequences
            for (var _k = 0; _k < array_length(global.__char_library); _k++) 
            { 
                // Replace sequences in the string using the string_replace_internal function
                _str = string_replace_internal(_str, global.__char_library[_k].key, global.__char_library[_k].char);
            }
            
            // Store the processed string in _struct, using the first row's columns as keys
            _struct[$ _array[_i][0]][$ _array[0][_j]] = _str;
        }
    } 
    
    // Return the final structured data
    return _struct;
}

// Retorna a linguagem padrão do sistema
function __language_get_system_language(){
	var _system_language = LANGUAGES.ENGLISH;
	var _os_language = os_get_language();
	switch(_os_language)
	{
		case "pt": 
			_system_language = LANGUAGES.PORTUGUESE; 
			break;
		
		case "en":
		case "en-US":
		case "en-UK":
		default:
			_system_language = LANGUAGES.ENGLISH;
			break;
	}
	
	show_debug_message($"System Language was set to {_system_language} from {_os_language}")
	
	return _system_language;
	
	// Some codes in case you need to add more languages
	/*
		"es": SPANISH
		"ru": RUSSIAN
		"ja": JAPANESE
		"ko": KOREAN
		"de": GERMAN
		"zh": CHINESE
			Region -> "HK"|"MO"|"TW": TRADITIONAL
				   -> Else: SIMPLIFIED
				   
		 os_get_region(); Function to get region
	*/
}

#endregion

#region Utils

/// @function					language_get_localized_text(_key, _language)
/// @description				Com essa função você pode localizar uma string a partir de uma Key presente no TSV
/// @param {string} _key		Key registrada no arquivo TSV
/// @param {real} [_language]	Idioma desejado utilizando o enum LANGUAGES, o padrão é o idioma ativo
/// @return {string}			Retorna o texto localizado
function language_get_localized_text(_key, _language = settings_get_language())
{
	// Check if key exists on dictionary
	var _check = struct_exists(global.language_text_dict, _key);
	var _temp = _key;
	
	// If key exists, get value
	if (_check){
		_temp =  global.language_text_dict[$ _key][$ global.language_tags[_language]];
	}
	
	return _temp;
}	

#endregion

#region Building database and systems
global.language_text_dict = __language_load_tsv_file(global.language_file_path);
#endregion


