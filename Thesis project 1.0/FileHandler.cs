using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Thesis_project_1._0 {
    class FileHandler {

        public string GetInput() {
            // Get users
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Title = "Choose .txt File";
            openFileDialog.Filter = ".txt|*.txt";
            string filePath = "";
            if (openFileDialog.ShowDialog() == DialogResult.OK) {
                filePath = openFileDialog.FileName;
            }
            // Open file to string
            return System.IO.File.ReadAllText(filePath);
        }

    }
}
