// Ваши JS-скрипты
// Инициализация Bootstrap-модальных окон (если требуется)
document.addEventListener('DOMContentLoaded', function() {
    var modals = document.querySelectorAll('.modal');
    modals.forEach(function(modal) {
        modal.addEventListener('show.bs.modal', function (event) {
            // Можно добавить логику при открытии модального окна
        });
    });
}); 