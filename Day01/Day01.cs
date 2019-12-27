using System;
using System.IO;
namespace advent_of_code_2015
{
    public class Day01
    {
        public void Run()
        {
            string input = File.ReadAllText("Day01/input.txt");

            int level = 0;
            for (int i = 0; i < input.Length; i++)
            {
                if (input[i] == '(')
                {
                    level++;
                }
                else
                {
                    level--;
                }

                if (level < 0)
                {
                    System.Console.WriteLine("Basement was reached at move " + (i + 1));
                    return;
                }
            }
        }
    }
}
