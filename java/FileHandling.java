 

import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

public class FileHandling {
	public List<String> findPhrase(final Path file) {
		HashMap<String, Integer> phrases = new HashMap<String, Integer>();
		try (BufferedReader br = Files.newBufferedReader(file, Charset.forName("ISO-8859-1"))) {
			while (br.ready()) {
				String line = br.readLine();
				String[] linePhrases = line.split("\\|");
				for (String phrase : linePhrases) {
					phrase = phrase.trim();
					if (phrase.length() <= 0)
						continue;
					if (!phrases.containsKey(phrase)) {
						phrases.put(phrase, 1);
					} else {
						phrases.put(phrase, phrases.get(phrase) + 1);
					}
				}
			}
			br.close();
		} catch (IOException e) {
			System.out.println("Please make sure you have the right txt file.");
			e.printStackTrace();
		}
		return appendList(phrases);
	}

	private List<String> appendList(final Map<String, Integer> phraseMap) {
		TreeMap<String, Integer> sPhrases = new TreeMap<String, Integer>(
				(key, value) -> phraseMap.get(key) > phraseMap.get(value) ? -1 : 1);
		sPhrases.putAll(phraseMap);
		List<String> listOfPhrase = new ArrayList<String>();
		int counter = 0;
		for (Map.Entry<String, Integer> entry : sPhrases.entrySet()) {
			listOfPhrase.add(entry.getKey());
			sPhrases.remove(entry.getKey());
			counter++;
			if (counter >= 100000)
				break;
		}
		return listOfPhrase;
	}
}
