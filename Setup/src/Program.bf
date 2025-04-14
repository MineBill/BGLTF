using System;
using BeefLibSetupHelper;

namespace Setup;

class Program
{
	public static void Main()
	{
		CMake.CheckDeps!();
		CMake.ConfigureAndBuild(".");
	}
}