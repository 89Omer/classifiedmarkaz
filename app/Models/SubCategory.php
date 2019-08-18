<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use TCG\Voyager\Models\Category;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Traits\Translatable;

class SubCategory extends Model
{
    //
    use Translatable;

    protected $translatable = ['subcategory_name'];

    protected $table = 'sub_categories';

    protected $fillable = ['subcategory_name'];

    public function parentCategoryId()
    {
        return $this->belongsTo(Category::class);
    }
}
