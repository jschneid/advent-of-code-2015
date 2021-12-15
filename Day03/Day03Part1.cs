using System;
using System.IO;
using System.Drawing;
using System.Collections.Generic;

namespace advent_of_code_2015
{
    public class Day03Part1
    {
        public void Run()
        {
            string inputLine = File.ReadAllLines("Day03/input.txt")[0];

            Point startingLocation = new Point(0, 0);
            HashSet<Point> visitedPoints = new HashSet<Point>();
            visitedPoints.Add(startingLocation);

            int x = 0;
            int y = 0;
            foreach (char move in inputLine)
            {
                switch (move)
                {
                    case '>':
                        x += 1;
                        break;
                    case '<':
                        x -= 1;
                        break;
                    case '^':
                        y += 1;
                        break;
                    case 'v':
                        y -= 1;
                        break;
                }
                visitedPoints.Add(new Point(x, y));
            }

            Console.WriteLine(visitedPoints.Count);
        }
    }
}
