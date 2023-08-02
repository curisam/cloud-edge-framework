

<?php
// Tick each 10.5 seconds

function reschedule_cb ($watcher, $now) {
   return $now + (10.5. - fmod($now, 10.5));
}

$w = new EvPeriodic(0., 0., "reschedule_cb", function ($w, $revents) {
   echo time(), PHP_EOL;
});

Ev::run();
?>

<?php
// Tick each 10.5 seconds

function reschedule_cb ($watcher, $now) {
   return $now + (10.5. - fmod($now, 10.5));
}

$w = new EvPeriodic(0., 0., "reschedule_cb", function ($w, $revents) {
   echo time(), PHP_EOL;
});

Ev::run();
?>

