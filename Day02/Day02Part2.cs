using System;
using System.IO;
using System.Linq;
namespace advent_of_code_2015
{
    public class Day02Part2
    {
        private int GetRibbonLength(int x, int y, int z)
        {
            int[] measurements = new int[] { x, y, z };
            Array.Sort(measurements);
            return measurements[0] * 2 + measurements[1] * 2;
        }

        private int GetBowLength(int x, int y, int z)
        {
            return x * y * z;
        }

        public void Run()
        {
            string[] lines = File.ReadAllLines("Day02/input.txt");

            int totalRibbonRequired = 0;
            foreach (string line in lines)
            {
                int[] dimensions = line.Split("x").Select(stringValue => Int32.Parse(stringValue)).ToArray();
                totalRibbonRequired += GetRibbonLength(dimensions[0], dimensions[1], dimensions[2]) +
                    GetBowLength(dimensions[0], dimensions[1], dimensions[2]);
            }

            Console.WriteLine("Total ribbon required: " + totalRibbonRequired);
        }
    }
}