from flask import Blueprint, render_template
import time

classax_bp = Blueprint('classax', __name__, static_folder='', template_folder='')

@classax_bp.route('/', methods=['GET'])
def main():
  return render_template('base.html', content='classax.html')

@classax_bp.route('/', methods=['POST'])
def timer():
  time.sleep(5)
  return 'Classed!'
