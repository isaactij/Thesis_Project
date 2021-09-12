using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Thesis_project_1._0 {
    class Program {

        [STAThread]
        static void Main(string[] args) {
            FileHandler fileHandler = new FileHandler();
            string fileText = fileHandler.GetInput();

        }


    }
}
