using System.Windows.Forms;

namespace Digger
{
    public class Player : ICreature
    {
        public CreatureCommand Act(int x, int y)
        {
            var igra = new CreatureCommand();
            var key = Game.KeyPressed;

            switch (key)
            {
                case Keys.Down when y + 1 < Game.MapHeight:
                    igra.DeltaY = 1;
                    break;
                case Keys.Left when x > 0:
                    igra.DeltaX = -1;
                    break;
                case Keys.Up when y > 0:
                    igra.DeltaY = -1;
                    break;
                case Keys.Right when x < Game.MapWidth - 1:
                    igra.DeltaX = 1;
                    break;
                case Keys.Down when y < Game.MapHeight - 1:
                    igra.DeltaY = 1;
                    break;
            }
            return igra;
        }
        public string GetImageFileName()
        {
            return "Digger.png";
        }
        public int GetDrawingPriority()
        {
            return 0;
        }
        public bool DeadInConflict(ICreature conflictedObject)
        {
            return false;
        }
    }
    public class Terrain : ICreature
    {
        public string GetImageFileName()
        {
            return "Terrain.png";
        }
        public int GetDrawingPriority()
        {
            return 1;
        }
        public bool DeadInConflict(ICreature conflictedObject)
        {
            return true;
        }

        public CreatureCommand Act(int x, int y)
        {
            return new CreatureCommand();
        }
    }
}
