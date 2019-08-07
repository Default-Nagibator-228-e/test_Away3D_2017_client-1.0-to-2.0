package mishin870.gui {

    public class RankUtils {

        public static var rankNames:Array = ["Новобранец", "Рядовой", "Ефрейтор", "Капрал", "Мастер-капрал", "Сержант", "Штаб-сержант", "Мастер-сержант", "Первый сержант", "Сержант-майор", "Уорэнт-офицер 1", "Уорэнт-офицер 2", "Уорэнт-офицер 3", "Уорэнт-офицер 4", "Уорэнт-офицер 5", "Младший лейтенант", "Лейтенант", "Старщий лейтенант", "Капитан", "Майор", "Подполковник", "Полковник", "Бригадир", "Генерал-майор", "Генерал-лейтенант", "Генерал", "Маршал"];
        public static var rankScores:Array = [0, 100, 500, 1500, 3700, 7100, 12300, 20000, 29000, 41000, 57000, 76000, 98000, 125000, 156000, 192000, 233000, 280000, 332000, 390000, 455000, 527000, 606000, 692000, 787000, 889000, 1000000];

        public static function getRankName(_arg1:int):String{
            return (rankNames[_arg1]);
        }
        public static function getRankMax(_arg1:int):int{
            if (_arg1 < (rankScores.length - 1)){
                return (rankScores[(_arg1 + 1)]);
            };
            return (0);
        }
        public static function getRankId(_arg1:int):int{
            var _local2:int;
            var _local3:int;
            while (_local3 < rankScores.length) {
                if (_arg1 >= rankScores[_local3]){
                    _local2 = _local3;
                };
                _local3++;
            };
            return (_local2);
        }

    }
}//package mishin870.gui 
