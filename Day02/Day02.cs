using System;
using System.IO;
using System.Linq;
namespace advent_of_code_2015
{
    public class Day02
    {
        private int GetPaperRequired(int l, int w, int h)
        {
            int[] sides = new int[3];
            sides[0] = 2 * l * w;
            sides[1] = 2 * w * h;
            sides[2] = 2 * h * l;
            int minimumSide = sides.Min() / 2;
            return sides.Sum() + minimumSide;
        }

        public void Run()
        {
            string[] lines = File.ReadAllLines("Day02/input.txt");

            int totalPaperRequired = 0;
            foreach (string line in lines)
            {
                int[] dimensions = line.Split("x").Select(stringValue => Int32.Parse(stringValue)).ToArray();
                totalPaperRequired += GetPaperRequired(dimensions[0], dimensions[1], dimensions[2]);
            }

            Console.WriteLine("Total paper required: " + totalPaperRequired);
        }


    }
}
