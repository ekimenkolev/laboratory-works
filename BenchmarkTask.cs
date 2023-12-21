using System;
using System.Diagnostics;
using NUnit.Framework;
using System.Text;

namespace StructBenchmarking
{
    public class Benchmark : IBenchmark
    {
        public double MeasureDurationInMs(ITask t, int x)
        {
            GC.Collect();                   
            GC.WaitForPendingFinalizers();  
            Stopwatch sw = new Stopwatch();
            t.Run();
            sw.Start();
            int i = 0;
            while (i < x)
            {
                t.Run();
                i++;
            }
            var time = sw.ElapsedMilliseconds;
            sw.Stop();
            return time / x;
        }
    }

    public class FirstMethod : ITask
    {
        public void Run()
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < 10000; i++)
                sb.Append("a");
            _ = sb.ToString();
        }
    }

    public class SecondMethod : ITask
    {
        public void Run()
        {
            _ = new string('a', 10000);
        }
    }

    [TestFixture]
    public class RealBenchmarkUsageSample
    {
        [Test]
        public void StringConstructorFasterThanStringBuilder()
        {
            var fr = new FirstMethod();
            var sd = new SecondMethod();
            var b = new Benchmark();
            var r1 = b.MeasureDurationInMs(fr, 10000);
            var r2 = b.MeasureDurationInMs(sd, 10000);
            Assert.AreEqual(r1, r2);
        }
    }
}
