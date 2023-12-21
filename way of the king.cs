using System.IO;

namespace Путь_короля
{
    class Program
    {
        public static int[] number = new int[4];

        static void Main()
        {
            int n, m;

            using (StreamReader sr = new StreamReader(input.txt))
            {
                string[] checkerboardDimensions = sr.ReadLine().Split(' ');
                n = int.Parse(checkerboardDimensions[0]);
                m = int.Parse(checkerboardDimensions[1]);
            }

            bool[,] visits = new bool[n, m];
            
            number[2] = n;
            number[3] = m;

            Bypass(visits, 0, 0);

            using StreamWriter sw = new StreamWriter(output.txt, true);
                sw.WriteLine(number[1]);
        }

        static void Bypass(bool[,] visits, int x, int y)
        {
            if (visits[x, y] == true)
                return;

            if (x + y == 0 &
                number[0] != 0 &
                number[0] != number[2]  number[3] - 1)
                return;

            if (x + y != 0)
            {
                number[0]++;
                visits[x, y] = true;
            }

            if (x + 1  number[2])
                Bypass(visits, x + 1, y);
            if (x - 1 = 0)
                Bypass(visits, x - 1, y);

            if (y + 1  number[3])
                Bypass(visits, x, y + 1);
            if (y - 1 = 0)
                Bypass(visits, x, y - 1);

            if (x - 1 = 0 &
                y - 1 = 0)
                Bypass(visits, x - 1, y - 1);
            if (x - 1 = 0 &
                y + 1  number[3])
                Bypass(visits, x - 1, y + 1);
            if (x + 1  number[2] &
                y - 1 = 0)
                Bypass(visits, x + 1, y - 1);
            if (x + 1  number[2] &
                y + 1  number[3])
                Bypass(visits, x + 1, y + 1);

            if (x + y == 0)
            {
                if (number[0] == number[2]  number[3] - 1)
                    number[1]++;
            }
            else
            {
                number[0]--;
                visits[x, y] = false;
            }
            return;
        }
    }
}