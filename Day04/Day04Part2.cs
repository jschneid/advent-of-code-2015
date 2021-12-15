using System;
using System.IO;
using System.Text;

namespace advent_of_code_2015
{
    public class Day04Part2
    {
        // Source: https://stackoverflow.com/a/24031467/12484
        private string CreateMD5(string input)
        {
            // Use input string to calculate MD5 hash
            using (System.Security.Cryptography.MD5 md5 = System.Security.Cryptography.MD5.Create())
            {
                byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(input);
                byte[] hashBytes = md5.ComputeHash(inputBytes);

                // Convert the byte array to hexadecimal string
                StringBuilder sb = new StringBuilder();
                for (int i = 0; i < hashBytes.Length; i++)
                {
                    sb.Append(hashBytes[i].ToString("X2"));
                }
                return sb.ToString();
            }
        }

        private int FindSixLeadingZeroesMD5(string secretKey)
        {
            int i = 0;
            while (CreateMD5(secretKey + i).Substring(0, 6) != "000000")
            {
                i++;
            }
            return i;
        }

        public void Run()
        {
            string secretKey = File.ReadAllLines("Day04/input.txt")[0];
            Console.WriteLine(FindSixLeadingZeroesMD5(secretKey));
        }
    }
}
