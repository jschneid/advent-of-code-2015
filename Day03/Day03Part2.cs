using System;
using System.IO;
using System.Drawing;
using System.Collections.Generic;

namespace advent_of_code_2015
{
    public class Day03Part2
    {
        public void PerformMove(char move, ref Point position)
        {
            switch (move)
            {
                case '>':
                    position.X += 1;
                    break;
                case '<':
                    position.X -= 1;
                    break;
                case '^':
                    position.Y += 1;
                    break;
                case 'v':
                    position.Y -= 1;
                    break;
            }
        }

        public void Run()
        {
            string inputLine = File.ReadAllLines("Day03/input.txt")[0];

            Point startingLocation = new Point(0, 0);
            HashSet<Point> visitedPoints = new HashSet<Point>();
            visitedPoints.Add(startingLocation);

            Point santaPosition = startingLocation;
            Point roboSantaPosition = startingLocation;
            bool santasTurn = true;
            foreach (char move in inputLine)
            {
                if (santasTurn)
                {
                    PerformMove(move, ref santaPosition);
                    visitedPoints.Add(santaPosition); 
                }
                else
                {
                    PerformMove(move, ref roboSantaPosition);
                    visitedPoints.Add(roboSantaPosition);
                }
                santasTurn = !santasTurn;
            }

            Console.WriteLine(visitedPoints.Count);
        }
    }
}
