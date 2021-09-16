using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Thesis_project_1._0 {
    class Program {

        [STAThread]
        static void Main(string[] args) {
            List<string> specialWords = new List<string>() { "for", "less", "plus" };
            // Dictionary<string, string> specialWords = new Dictionary<string, string>() { { "for", "for(" }, { "less", "less" } };
            Dictionary<string, string> singleDigitNumbers = new Dictionary<string, string>{ { "one", "1"} };
            string newText = "";
            FileHandler fileHandler = new FileHandler();
            string fileText = fileHandler.GetInput();
            fileText = fileText.ToLower();
            string[] dividedString = fileText.Split(' ');
            bool forLoopBeingConstructed = false;
            int forLoopDefinitionSection = 1;
            // foreach (string word in dividedString) {
            for (int wordIndex = 0; wordIndex < dividedString.Length; wordIndex++) {
                string word = dividedString[wordIndex];
                string nextWord = "";
                if (specialWords.Contains(word)) {
                    switch (word) {
                        case "for":
                            forLoopBeingConstructed = true;
                            newText += "for(";
                            break;
                        case "less":
                            nextWord = dividedString[wordIndex + 1];
                            if (nextWord == "than") {
                                newText += "<";
                                wordIndex++;
                            }
                            break;
                        case "plus":
                            nextWord = dividedString[wordIndex + 1];
                            if (nextWord == "plus") {
                                newText += "++";
                                wordIndex++;
                            }
                            break;
                    }
                } else if (singleDigitNumbers.ContainsKey(word)) {
                    newText += singleDigitNumbers[word];
                    word = singleDigitNumbers[word];
                } else {
                    newText += word;
                }
                if (forLoopBeingConstructed) {
                    int number = 0;
                    if (int.TryParse(word, out number)) {
                        if (forLoopDefinitionSection == 3) {
                            newText += ") {\n";
                        }
                        newText += ";";
                        forLoopDefinitionSection++;
                        if (forLoopDefinitionSection > 3) {
                            forLoopBeingConstructed = false;
                            forLoopDefinitionSection = 1;
                        }
                    }
                }
                newText += " ";
            }
            Console.WriteLine(newText);

        }


    }
}
