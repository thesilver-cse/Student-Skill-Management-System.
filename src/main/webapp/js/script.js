/**
 * SkillTrack - Client Side Helper Script
 * Handles form validation, interactive progress sliders, and alert dismissals.
 */

document.addEventListener('DOMContentLoaded', function () {
    
    // 1. Sync Progress Range Slider with Number / Display
    const progressRange = document.getElementById('progressRange');
    const progressDisplay = document.getElementById('progressDisplay');
    const progressInput = document.getElementById('progressInput');

    if (progressRange && progressDisplay) {
        progressRange.addEventListener('input', function () {
            progressDisplay.textContent = this.value + '%';
            if (progressInput) {
                progressInput.value = this.value;
            }
        });
    }

    if (progressInput && progressRange) {
        progressInput.addEventListener('input', function () {
            let val = parseInt(this.value, 10);
            if (isNaN(val)) val = 0;
            if (val < 0) val = 0;
            if (val > 100) val = 100;
            progressRange.value = val;
            if (progressDisplay) {
                progressDisplay.textContent = val + '%';
            }
        });
    }

    // 2. Auto-Dismiss Alert Messages after 4 seconds
    const autoAlerts = document.querySelectorAll('.alert-dismiss-auto');
    if (autoAlerts.length > 0) {
        setTimeout(function () {
            autoAlerts.forEach(function (alert) {
                alert.style.transition = 'opacity 0.5s ease';
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 500);
            });
        }, 4000);
    }
});

/**
 * Confirms deletion of a Skill record
 * @param {string} skillName Name of skill
 * @returns {boolean}
 */
function confirmSkillDelete(skillName) {
    return confirm("Are you sure you want to delete the skill '" + skillName + "'? This action cannot be undone.");
}

/**
 * Confirms deletion of a Goal record
 * @param {string} goalName Name of goal
 * @returns {boolean}
 */
function confirmGoalDelete(goalName) {
    return confirm("Are you sure you want to delete the goal '" + goalName + "'?");
}

/**
 * Validates registration password match
 * @returns {boolean}
 */
function validateRegisterForm() {
    const pass = document.getElementById('password');
    const confirmPass = document.getElementById('confirmPassword');
    if (pass && confirmPass && pass.value !== confirmPass.value) {
        alert("Passwords do not match. Please re-enter.");
        confirmPass.focus();
        return false;
    }
    return true;
}
